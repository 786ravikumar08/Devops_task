variable "aws_region" {
  description = "aws region, e.g us-west-2"
}

variable "bastion_instance_group" {
  default = "bastion"
}

variable "bastion_root_device_size" {
  default = 100
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "public_subnets" {
  description = "Public subnet id"
}

variable "customer" {
  description = "name of the customer"
}

variable "environment" {
  description = "name of the stack to be installed (xyz-sandbox,preprod2)"
}

variable "bastion_ami" {
  default = {
    ap-southeast-1 = "ami-0ca13b3dabeb6c66d"
    ap-south-1     = "ami-0620d12a9cf777c87"
  }
}

variable "keypair" {
  description = "keypair to put on the ec2 instance"
}

variable "bastion_iam" {
  default = ""
}

variable "white_bastion_ips" {
  description = "The Comma seperated list of IPs to be whitlisted to Bastion node"
}

variable "elasticsearch_sg_blue" {
  description = "Security group of elasticsearch blue node"
}

variable "elasticsearch_sg_green" {
  description = "Security group of elasticsearch green node"
}
