data "null_data_source" "cidr" {
  count = "6"

  inputs = {
    public_cidr  = cidrsubnet(var.vpc_cidr, 4, count.index + 1)
    private_cidr = cidrsubnet(var.vpc_cidr, 4, count.index + 7)
  }
}

module "subnet_public" {
  source                  = "../subnet"
  vpc_id                  = aws_vpc.vpc.id
  prefix                  = var.cloud_name
  subnet_cidrs            = join(",", data.null_data_source.cidr.*.outputs.public_cidr)
  map_public_ip_on_launch = true
  natgw                   = ""
  gateway                 = aws_internet_gateway.igw.id
  customer                = var.customer
  environment             = var.environment
  availability_zones      = var.availability_zones
}

module "subnet_private" {
  source                  = "../subnet"
  vpc_id                  = aws_vpc.vpc.id
  prefix                  = var.cloud_name
  subnet_cidrs            = join(",", data.null_data_source.cidr.*.outputs.private_cidr)
  map_public_ip_on_launch = false
  natgw                   = aws_nat_gateway.natgw.id
  gateway                 = ""
  customer                = var.customer
  environment             = var.environment
  availability_zones      = var.availability_zones
}
