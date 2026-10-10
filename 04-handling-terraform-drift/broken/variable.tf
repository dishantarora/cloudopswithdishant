variable "aws_region" {
    type = string
    description = "AWS region for resources"
    default = "us-east-1"
}

variable "bucket_name" {
    type = string
    description = "Name of the S3 bucket"
}

variable "sg_name" {
    type = string
    description = "Name of the security group"
}