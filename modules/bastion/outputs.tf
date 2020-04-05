output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}