terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

# Terraform will try to CREATE this bucket
resource "aws_s3_bucket" "cloudopswithdishant-demo-bucket" {
    bucket = "cloudopswithdishant-demo-bucket"
}
