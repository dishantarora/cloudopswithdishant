variable "aws_region" {
    type = string
    description = "AWS region for resources"
    default = "us-east-1"
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
    default = "vpc-0123456789abcdef0"
}