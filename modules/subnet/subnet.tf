locals {
  cidr_blocks = split(",", var.subnet_cidrs)

  default_tags = {
    managed_by  = "terraform"
    project     = var.customer
    environment = var.environment
  }
}

resource "aws_subnet" "sn" {
  vpc_id                  = var.vpc_id
  count                   = length(var.availability_zones)
  cidr_block              = element(local.cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(local.default_tags, map(
    "Name", format("%s-%s-%d", var.prefix, var.map_public_ip_on_launch ? "public" : "private", count.index),
    "type", var.map_public_ip_on_launch ? "public" : "private"
  ))
}

resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id
  tags   = merge(local.default_tags, map("Name", "${var.prefix}-rtb"))
}

resource "aws_route" "rt" {
  route_table_id         = aws_route_table.rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.natgw
  gateway_id             = var.gateway
}

resource "aws_route_table_association" "rta_public" {
  count          = length(local.cidr_blocks)
  subnet_id      = element(aws_subnet.sn.*.id, count.index)
  route_table_id = aws_route_table.rtb.id
}
