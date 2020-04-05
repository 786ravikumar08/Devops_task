data "template_file" "default-es" {
  template = file("${path.module}/scripts/es-cloudinit.tmpl")

  vars = {
    customer    = var.customer
    environment = var.environment
    aws_region  = var.aws_region
  }
}

data "template_cloudinit_config" "default-es" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.default-es.rendered
  }
}


################################# blue asg,launch config and policy start #########################

resource "aws_launch_configuration" "default-es-blue" {
  name_prefix       = "${var.customer}-${var.environment}-es-blue"
  security_groups   = [aws_security_group.default-es-blue.id]
  enable_monitoring = true
  ebs_optimized     = false

  image_id      = lookup(var.elasticsearch_ami, var.aws_region)
  instance_type = var.es_instance_type
  key_name      = var.keypair
  user_data     = data.template_cloudinit_config.default-es.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.elasticsearch_root_device_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "default-es-blue" {
  name                      = "${var.customer}-${var.environment}-es-blue"
  health_check_grace_period = 60
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.default-es-blue.id

  max_size         = var.elasticsearch_blue_asg_max
  min_size         = var.elasticsearch_blue_asg_min
  desired_capacity = var.elasticsearch_blue_asg_desired

  vpc_zone_identifier = split(",", var.private_subnets)

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity","GroupInServiceInstances", "GroupPendingInstances","GroupStandbyInstances","GroupTerminatingInstances","GroupTotalInstances"]


  tag  {
    key                 = "Name"
    value               = "${var.customer}-${var.environment}-es-blue"
    propagate_at_launch = true
  }

    tag  {
      key                 = "service"
      value               = "elasticsearch"
      propagate_at_launch = true
    }

    tag  {
      key                 = "environment"
      value               = var.environment
      propagate_at_launch = true
    }

    tag  {
      key                 = "project"
      value               = var.customer
      propagate_at_launch = true
    }

  lifecycle {
    create_before_destroy = true
  }

  suspended_processes = ["Terminate"]
  default_cooldown    = 300

}

################################# Blue End ##########################

################################# Green ASG,Launch Config and Policy Start ########################

resource "aws_launch_configuration" "default-es-green" {
  name_prefix       = "${var.customer}-${var.environment}-es-green"
  security_groups   = [aws_security_group.default-es-green.id]
  enable_monitoring = true
  ebs_optimized     = false

  image_id      = lookup(var.elasticsearch_ami, var.aws_region)
  instance_type = var.es_instance_type
  key_name      = var.keypair
  user_data     = data.template_cloudinit_config.default-es.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.elasticsearch_root_device_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "default-es-green" {
  name                      = "${var.customer}-${var.environment}-es-green"
  health_check_grace_period = 60
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.default-es-green.id

  max_size         = var.elasticsearch_green_asg_max
  min_size         = var.elasticsearch_green_asg_min
  desired_capacity = var.elasticsearch_green_asg_desired

  vpc_zone_identifier = split(",", var.private_subnets)

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity","GroupInServiceInstances", "GroupPendingInstances","GroupStandbyInstances","GroupTerminatingInstances","GroupTotalInstances"]


  tag  {
    key                 = "Name"
    value               = "${var.customer}-${var.environment}-es-green"
    propagate_at_launch = true
  }

  tag  {
    key                 = "service"
    value               = "elasticsearch"
    propagate_at_launch = true
  }

  tag  {
    key                 = "environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag  {
    key                 = "project"
    value               = var.customer
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  suspended_processes = ["Terminate"]
  default_cooldown    = 300

}

################################# Green End ########################