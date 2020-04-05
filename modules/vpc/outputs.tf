output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "cloud_name" {
  value = var.cloud_name
}

output "private_subnet_ids" {
  value = module.subnet_private.subnet_ids
}

output "public_subnet_ids" {
  value = module.subnet_public.subnet_ids
}

output "default_security_group_id" {
  value = aws_vpc.vpc.default_security_group_id
}

output "nat_eip_ids" {
  value = [aws_eip.nateip.*.id]
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "natgw_id" {
  value = aws_nat_gateway.natgw.id
}

