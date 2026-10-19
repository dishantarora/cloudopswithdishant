output "vpc_id" {
  description = "ID of the VPC for use by the security-group configuration"
  value       = aws_vpc.bootstrap.id
}

output "vpc_cidr" {
  description = "CIDR range assigned to the VPC"
  value       = aws_vpc.bootstrap.cidr_block
}