variable "cloud_name" {
  default     = ""
  description = "designation for this vpc cloud"
}

variable "aws_region" {
  description = "aws region to create the vpc [eu-west-1|us-west-2|..]"
}

variable "environment" {
  description = "name of the environment"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private dns within the vpc"
  default     = true
}

variable "vpc_cidr" {
  default = "172.32.0.0/16"
}

variable "enable_dns_support" {
  description = "should be true if you want to use private dns within the vpc"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public ip on launch"
  default     = true
}

variable "private_propagating_vgws" {
  description = "a list of vgws the private route table should propagate."
  default     = []
}

variable "public_propagating_vgws" {
  description = "a list of vgws the public route table should propagate."
  default     = []
}

variable "customer" {
  description = "name of the customer"
}

variable "availability_zones" {}