variable "vpc_id" {}

variable "natgw" {}

variable "gateway" {}

variable "environment" {
  description = "name of the stack to be installed (xyz-sandbox,preprod2)"
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public ip on launch"
  default     = false
}

variable "security_group_ids" {
  default = []
}

variable "subnet_cidrs" {
  description = "the number of cidrs on this list determines how many subnets are created"
}

variable "prefix" {
  description = "prefix for the resources created, normally same as stack_name"
}

variable "customer" {
  description = "name of the customer"
}

variable "availability_zones" {}
