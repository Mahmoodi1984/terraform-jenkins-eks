terraform {
  backend "s3" {
    bucket = "mahmoodi-cloud.de"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}