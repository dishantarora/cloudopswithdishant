resource "aws_s3_bucket" "demo_bucket" {
    bucket = var.bucket_name
}

# Artificial delay to give you time to abort the run mid-flight
resource "null_resource" "delay" {
    provisioner "local-exec" {
        command = "python3 -c 'import time; time.sleep(60)'"
    }
}