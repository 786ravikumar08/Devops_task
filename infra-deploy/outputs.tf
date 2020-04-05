output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "es_blue_sg_id" {
  value = module.elasticsearch.es_blue_sg_id
}

output "es_green_sg_id" {
  value = module.elasticsearch.es_green_sg_id
}

output "bastion_sg_id" {
  value = module.bastion.bastion_sg_id
}
output "bastion_ip" {
  value = module.bastion.bastion_ip
}