variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "AWS region for deployments"
}

variable "bucket_name" {
    type = string
    default = "cloudopswithdishant-demo-bucket-173166704767-us-east-1-an"
    description = "AWS S3 bucket"
}
