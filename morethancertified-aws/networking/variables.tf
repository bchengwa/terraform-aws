#morethancertified-aws/networking/variables.tf
variable "vpc_cidr" {
  default = "10.100.0.0:16"
  type = string
}

variable "public_cidrs" {
  type = list(string)
}

variable "private_cidrs" {
  type = list(string)
}

variable "public_subnet_count" {
  type = number
}

variable "private_subnet_count" {
  type = number
}