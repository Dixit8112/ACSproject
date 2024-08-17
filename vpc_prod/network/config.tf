terraform {
  required_version = ">= 1.5.0"
  backend "s3" {
    bucket = "prodgroup12"
    key    = "vpc_prod/networkfile/terraform.tfstate"
    region = "us-east-1"
  }
}
