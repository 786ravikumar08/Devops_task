variable "customer" {
  description = "name of the customer"
}

variable "environment" {
  description = "name of the stack to be installed (xyz-sandbox,preprod2)"
}

variable "aws_region" {
  description = "aws region, e.g us-west-2"
}

variable "elasticsearch_blue_asg_min" {
  description = "Min numbers of servers in asg"
  default     = 1
}

variable "elasticsearch_blue_asg_max" {
  description = "Max numbers of servers in asg"
  default     = 1
}

variable "elasticsearch_blue_asg_desired" {
  description = "Desired numbers of servers in asg"
  default     = 1
}

variable "elasticsearch_green_asg_min" {
  description = "Min numbers of servers in asg"
  default     = 0
}

variable "elasticsearch_green_asg_max" {
  description = "Max numbers of servers in asg"
  default     = 0
}

variable "elasticsearch_green_asg_desired" {
  description = "Desired numbers of servers in asg"
  default     = 0
}

variable "elasticsearch_root_device_size" {
  default = 100
}

variable "es_instance_type" {
  description = "instance size to create"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "vpc id"
}


variable "keypair" {
  description = "Keypair to put on the EC2 instance"
}

variable "elasticsearch_ami" {
  default = {
    ap-southeast-1 = "ami-0ca13b3dabeb6c66d"
    ap-south-1     = "ami-0620d12a9cf777c87"
  }
}

variable "bastion_sg" {
  description = "Security group of bastion"
}

variable "private_subnets" {
  description = "Private subnet id"
}