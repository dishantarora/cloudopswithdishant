variable "aws_region" {
  description = "AWS region in which to create the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the bootstrap VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the VPC"
  type        = string
}