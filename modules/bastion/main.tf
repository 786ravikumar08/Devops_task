data "template_file" "bastion" {
  template = file("${path.module}/scripts/bastion.tmpl")

  vars = {
    customer    = var.customer
    environment = var.environment
    aws_region  = var.aws_region
  }
}

data "template_cloudinit_config" "bastion" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.bastion.rendered
  }
}

resource "aws_network_interface" "default" {
  subnet_id       = element(split(",",var.public_subnets), 1)
  security_groups = [
    aws_security_group.bastion.id]

  tags = {
    Name        = "${var.customer}-${var.environment}-ni"
    environment = var.environment
    project     = var.customer
  }
}

resource "aws_instance" "bastion" {
  ami                  = lookup(var.bastion_ami, var.aws_region)
  instance_type        = var.bastion_instance_type
  key_name             = var.keypair
  user_data            = data.template_cloudinit_config.bastion.rendered
  iam_instance_profile = var.bastion_iam

  root_block_device {
    volume_size = var.bastion_root_device_size
  }

  network_interface {
    network_interface_id = aws_network_interface.default.id
    device_index         = 0
  }

  tags = {
    Name        = "${var.customer}-${var.environment}-bastion"
    service     = "bastion"
    environment = var.environment
    project     = var.customer
  }
}

resource "aws_security_group" "bastion" {
  vpc_id      = var.vpc_id
  name        = "${var.customer}-${var.environment}-bastion-sg"
  description = "security group that allows ssh and egress traffic to the nodes"

  tags = {
    Name        = "${var.customer}-${var.environment}-bastion-sg"
    environment = var.environment
    project     = var.customer
  }

  lifecycle {
    create_before_destroy = true
  }
}

## ingress rule #1
resource "aws_security_group_rule" "allow-bastion-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = split(",",var.white_bastion_ips)
}

## egress rule #1
resource "aws_security_group_rule" "bastion-es-blue-ssh" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  source_security_group_id = var.elasticsearch_sg_blue
}

## egress rule #2
resource "aws_security_group_rule" "bastion-es-green-ssh" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  source_security_group_id = var.elasticsearch_sg_green
}


## egress rule #3
resource "aws_security_group_rule" "allow-bastion-internet-access" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"]
}
