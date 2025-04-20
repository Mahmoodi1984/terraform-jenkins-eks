terraform {
  backend "s3" {
    bucket = "backend-logs-eks"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}