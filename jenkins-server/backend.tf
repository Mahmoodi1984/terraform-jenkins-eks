terraform {
  backend "s3" {
    bucket = "mahmoodi-tech.de"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}