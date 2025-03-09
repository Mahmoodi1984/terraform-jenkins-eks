terraform {
  backend "s3" {
    bucket = "mahmoodi-cloud.de"
    key    = "eks/terraform.tfstate"
    region = "eu-central-1"

  }
}