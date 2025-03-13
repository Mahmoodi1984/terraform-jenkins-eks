terraform {
  backend "s3" {
    bucket = "mahmoodi-tech.de"
    key    = "eks/terraform.tfstate"
    region = "eu-central-1"

  }
}