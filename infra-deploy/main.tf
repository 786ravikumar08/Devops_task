provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "account_id" {}
data "aws_region" "current" {}

module "vpc" {
  source             = "../modules/vpc"
  cloud_name         = "${var.customer}-${var.environment}"
  environment        = var.environment
  aws_region         = var.aws_region
  customer           = var.customer
  availability_zones = data.aws_availability_zones.available.names
}

module "bastion" {
  source            = "../modules/bastion"
  vpc_id            = module.vpc.vpc_id
  environment       = var.environment
  aws_region        = var.aws_region
  customer          = var.customer
  public_subnets    = module.vpc.public_subnet_ids
  white_bastion_ips = var.white_bastion_ips
  elasticsearch_sg_blue  = module.elasticsearch.es_blue_sg_id
  elasticsearch_sg_green  = module.elasticsearch.es_green_sg_id
  keypair           = var.keypair
}

module "elasticsearch" {
  source          = "../modules/elasticsearch"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  environment     = var.environment
  aws_region      = var.aws_region
  customer        = var.customer
  bastion_sg      = module.bastion.bastion_sg_id
  keypair         = var.keypair

}
