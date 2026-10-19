# Circular Dependency Deadlocks

This example demonstrates a circular dependency between two AWS security groups, then shows how to restructure the rules to let Terraform build a valid dependency graph.

## Folder Overview

- `bootstrap/` creates a VPC used by the security-group examples. It has its own Terraform state and outputs the VPC ID.
- `broken/` intentionally defines mutually referencing security groups with inline ingress rules. Run `terraform plan` here to reproduce Terraform's dependency-cycle error locally. The plan should fail before creating AWS resources; do not run `terraform apply` from this folder.
- `fixed/` creates the security groups first and defines their ingress rules as separate resources. This removes the resource dependency cycle and is the configuration to apply.

Each folder is a separate Terraform root with its own provider lock file and local state. Terraform does not automatically pass outputs or state between these folders.

## Prerequisites

- Terraform 1.0 or later.
- AWS CLI configured with credentials for an AWS account and permissions to create and delete VPCs and security groups.
- A region configured in the selected AWS CLI profile.

In the same terminal session, set the Terraform region variable from the default AWS CLI profile:

```sh
export TF_VAR_aws_region="$(aws configure get region)"
```

For a named profile, use that profile for both credentials and region:

```sh
export AWS_PROFILE=your-profile
export TF_VAR_aws_region="$(aws configure get region --profile "$AWS_PROFILE")"
```

Check that the region is non-empty and that AWS credentials work before applying:

```sh
printf '%s\n' "$TF_VAR_aws_region"
aws sts get-caller-identity
```

If the region is empty, configure one with `aws configure set region us-east-1` (or configure the selected profile). Keep credentials out of Terraform files.

## Create the VPC

Run the bootstrap configuration first. Its `terraform.tfvars` must provide `vpc_name` and `vpc_cidr`; the region is provided above through `TF_VAR_aws_region`.

```sh
terraform -chdir=bootstrap init
terraform -chdir=bootstrap plan
terraform -chdir=bootstrap apply
terraform -chdir=bootstrap output -raw vpc_id
```

Copy the resulting VPC ID into the `vpc_id` value in the local `terraform.tfvars` for the security-group configuration you plan to use. Provide `app_sg_name` and `db_sg_name` there as well. The repository ignores real `.tfvars` files, so do not commit account-specific values.

## Reproduce and Fix

To reproduce the issue, initialize and plan the broken configuration:

```sh
terraform -chdir=broken init
terraform -chdir=broken plan
```

Terraform is expected to report a cycle. This is a local graph-planning error, not an AWS state-lock operation, and no apply is needed to reproduce it.

To apply the fix, plan and apply the fixed configuration:

```sh
terraform -chdir=fixed init
terraform -chdir=fixed plan
terraform -chdir=fixed apply
```

Do not apply both `broken/` and `fixed/` with the same security-group names. They use separate Terraform states, but AWS requires security-group names to be unique within a VPC, so the configurations would conflict. Use only `fixed/` for deployment.

## Destroy Resources

Destroy dependent security groups before the VPC. From the repository root, preview and destroy the fixed stack if it was applied:

```sh
terraform -chdir=fixed plan -destroy
terraform -chdir=fixed destroy
```

If the broken stack was ever applied and has resources in its state, destroy those before the VPC too. Normally it should only have been planned and should have no AWS resources.

After the security groups are gone, preview and destroy the bootstrap VPC:

```sh
terraform -chdir=bootstrap plan -destroy
terraform -chdir=bootstrap destroy
```

Review each plan and confirm the prompts. Do not delete Terraform state files before destroying resources: each configuration needs its state to know what it manages. Resources created outside these Terraform states are not removed by these commands.
