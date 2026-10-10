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

# 1. Create Security Group Containers WITHOUT Inline Rules
resource "aws_security_group" "app_sg" {
    name = var.app_sg_name
    description = "Application Security Group"
    vpc_id = var.vpc_id
}

resource "aws_security_group" "db_sg" {
    name = var.db_sg_name
    description = "Database Security Group"
    vpc_id = var.vpc_id
}

# 2. Define Rules as Seperate Standalone Resources
# Allow DB SG to receive traffic on 5432 from App SG
resource "aws_security_group_rule" "allow_app_to_db" {
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_group_id = aws_security_group.db_sg.id # Attached to DB SG
    source_security_group_id = aws_security_group.app_sg.id  # Source is App SG
}

# Allow App SG to receive traffic on 8080 from DB SG
resource "aws_security_group_rule" "allow_db_to_app" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_group_id = aws_security_group.app_sg.id  # Attached to App SG
    source_security_group_id = aws_security_group.db_sg.id # Source is DB SG
}