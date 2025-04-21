terraform {
  backend "s3" {
    bucket = "backend-logs-jenkins"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}