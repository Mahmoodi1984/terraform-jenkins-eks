variable "vpc_cidr" {
  description = "CIDR FOR VPC"
  type        = string

}

variable "public_subnets" {
  description = "PUBLIC SUBNET CIDR"
  type        = list(string)

}

variable "instance_type" {
  description = "TYPE OF INSTANCE FOR JENKINS"
  type        = string

}