data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(local.default_tags, map("Name", "${var.cloud_name}-vpc"))
}

resource "aws_eip" "nateip" {
  vpc  = true
  tags = merge(local.default_tags, map("Name", "${var.cloud_name}-eip"))
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.default_tags, map("Name", "${var.cloud_name}-igw"))
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = element(split(",",module.subnet_public.subnet_ids),1)
  depends_on    = [ aws_internet_gateway.igw ]
  tags          = merge(local.default_tags, map("Name", "${var.cloud_name}-nat"))
}
