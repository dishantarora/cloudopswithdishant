terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "cloudopswithdishant-dev-storage-173166704767-us-east-1-an"
    key = "github-actions-demo/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "cloudopswithdishant-tf-locks"
  }
}

provider "aws" {
    region = "us-east-1"
}

variable "db_password" {
    type = string
    sensitive = true
}

resource "aws_s3_bucket" "demo" {
    bucket = "cloudopswithdishant-oidc-demo-bucket"
    tags = {
      Environment = "Dev"
      SecretCheck = var.db_password != "" ? "Configured" : "Missing"
    }
}