terraform {
  backend "s3" {
    bucket = "backend-logs-eks"
    key    = "eks/terraform.tfstate"
    region = "eu-central-1"

  }
}