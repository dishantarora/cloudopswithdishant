output "s3_bucket" {
    description = "Id of drift demo S3 bucket"
    value = aws_s3_bucket.drift_demo.id
}

output "web_sg" {
    description = "Id of web security group"
    value = aws_security_group.web_sg.id
}