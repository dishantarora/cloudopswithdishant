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
    region = var.aws_region 
}

# Security Group A (App Tier) - Depends on SG B
resource "aws_security_group" "app_sg" {
    name = var.app_sg_name 
    description = "Application Security Group"
    vpc_id = var.vpc_id

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        security_groups = [aws_security_group.db_sg.id] # Reference to SG B
    }
}

# Security Group B (Database Tier) - Depends on SG A
resource "aws_security_group" "db_sg" {
    name = var.db_sg_name 
    description = "Database Security Group"
    vpc_id = var.vpc_id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.app_sg.id] #Reference to SG A
    }
}