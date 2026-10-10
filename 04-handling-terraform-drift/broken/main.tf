terraform {
  required_version = ">= 1.0"
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
}

# 1. Managed S3 bucket
resource "aws_s3_bucket" "drift_demo" {
  bucket = var.bucket_name

  tags = {
    Environment = "Dev"
    ManagedBy = "Terraform"
  }
}

# 2. Managed Security Group
resource "aws_security_group" "web_sg" {
  name = var.sg_name
  description = "Security group for web server"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}