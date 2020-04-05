##############################################
## Security Group for Elasticsearch Blue node
##############################################

resource "aws_security_group" "default-es-blue" {
  name        = "${var.customer}-${var.environment}-es-sg-blue"
  vpc_id      = var.vpc_id
  description = "allows external incoming http/https"

  tags = {
    name        = "${var.customer}-${var.environment}-es-sg-blue"
    environment = var.environment
  }
}

## ingress rule #1
resource "aws_security_group_rule" "es-blue-ssh-bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-blue.id
  source_security_group_id = var.bastion_sg
}

## ingress rule #2
resource "aws_security_group_rule" "allow-es-rest-blue" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-blue.id
  source_security_group_id = aws_security_group.default-es-blue.id
}

## ingress rule #3
resource "aws_security_group_rule" "allow-es-transport-blue" {
  type                     = "ingress"
  from_port                = 9300
  to_port                  = 9300
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-blue.id
  source_security_group_id = aws_security_group.default-es-blue.id
}

## egress rule #1
resource "aws_security_group_rule" "es-blue-outbound-https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.default-es-blue.id
  cidr_blocks       = ["0.0.0.0/0"]
}

## egress rule #2
resource "aws_security_group_rule" "es-blue-outbound-transport" {
  type              = "egress"
  self              = true
  from_port         = 9300
  to_port           = 9300
  protocol          = "tcp"
  security_group_id = aws_security_group.default-es-blue.id
}

##############################################
## Security Group for Elasticsearch Green node
##############################################

resource "aws_security_group" "default-es-green" {
  name        = "${var.customer}-${var.environment}-es-sg-green"
  vpc_id      = var.vpc_id
  description = "allows external incoming http/https"

  tags = {
    name        = "${var.customer}-${var.environment}-es-sg-green"
    environment = var.environment
  }
}

## ingress rule #1
resource "aws_security_group_rule" "es-green-ssh-bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-green.id
  source_security_group_id = var.bastion_sg
}

## ingress rule #2
resource "aws_security_group_rule" "allow-es-rest-green" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-green.id
  source_security_group_id = aws_security_group.default-es-green.id
}

## ingress rule #3
resource "aws_security_group_rule" "allow-es-transport-green" {
  type                     = "ingress"
  from_port                = 9300
  to_port                  = 9300
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default-es-green.id
  source_security_group_id = aws_security_group.default-es-green.id
}

## egress rule #1
resource "aws_security_group_rule" "es-green-outbound-https" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.default-es-green.id
  cidr_blocks       = ["0.0.0.0/0"]
}

## egress rule #2
resource "aws_security_group_rule" "es-green-outbound-transport" {
  type              = "egress"
  self              = true
  from_port         = 9300
  to_port           = 9300
  protocol          = "tcp"
  security_group_id = aws_security_group.default-es-green.id
}
