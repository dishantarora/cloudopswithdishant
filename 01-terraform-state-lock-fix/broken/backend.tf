terraform {
  required_version = ">= 1.5.0"
  backend "s3" {
    bucket = "cloudopswithdishant-dev-storage-173166704767-us-east-1-an"
    key = "lock-demo/state-lock-demo.tfstate"
    region = "us-east-1"
    dynamodb_table = "cloudopswithdishant-tf-locks"
    encrypt = true
  }
}