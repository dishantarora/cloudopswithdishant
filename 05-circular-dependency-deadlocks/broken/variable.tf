variable "aws_region" {
    type = string
    description = "AWS region for resources"
}

variable "app_sg_name" {
    type = string
    description = "Security group name of app"
}

variable "db_sg_name" {
    type = string
    description = "Security group namd of db"
}

variable "vpc_id" {
    type = string
    description = "VPC ID from AWS account"
}