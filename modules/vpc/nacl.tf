resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = split(",", module.subnet_public.subnet_ids)
  tags       = merge(local.default_tags, map("Name", "${var.cloud_name}-acl-public"))
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = split(",", module.subnet_private.subnet_ids)
  tags       = merge(local.default_tags, map("Name", "${var.cloud_name}-acl-private"))
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  tags                   = merge(local.default_tags, map("Name", "${var.cloud_name}-acl-default"))
}

resource "aws_network_acl_rule" "public_egress" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_ingresses" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_egress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_ingresses" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
