variable "vpc_cidr" {
  description = "CIDR FOR VPC"
  type        = string

}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)

}

variable "public_subnets" {
  description = "PUBLIC SUBNET CIDR"
  type        = list(string)

}