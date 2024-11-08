locals {
  max_zones              = 3
  zones_selected         = [for zone in data.aws_availability_zones.available.names : zone if contains(var.availability_zones, zone)]
  azs                    = coalescelist(local.zones_selected, slice(data.aws_availability_zones.available.names, 0, local.max_zones))
  vpc_cni_actived        = try(var.vpc_cni, null) == null ? false : true
  vpc_cni_custom_enabled = try(var.vpc_cni.custom_networking, false)
  secondary_cidr_blocks  = local.vpc_cni_actived && local.vpc_cni_custom_enabled ? var.vpc_secondary_cidr_blocks : []
  intra_subnets_secondary = {
    cidr_blocks = var.vpc_secondary_cidr_blocks[0],
    newbits     = 4
    netnum      = 1
  }
  intra_subnets_primary = {
    cidr_blocks = var.vpc_cidr,
    newbits     = 8
    netnum      = 52
  }
  intra_subnets = local.vpc_cni_actived && local.vpc_cni_custom_enabled ? local.intra_subnets_secondary : local.intra_subnets_primary
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                  = "${var.cluster_name}-vpc"
  cidr                  = var.vpc_cidr
  secondary_cidr_blocks = local.secondary_cidr_blocks

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 48)]
  intra_subnets    = [for k, v in local.azs : cidrsubnet(local.intra_subnets.cidr_blocks, local.intra_subnets.newbits, k + local.intra_subnets.netnum)]
  database_subnets = var.create_database_subnets ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k + 6)] : []

  create_database_subnet_group = var.create_database_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

}
# private nat gateway
resource "aws_nat_gateway" "private_nat" {
  # count             = local.vpc_cni_actived && local.vpc_cni_custom_enabled ? 1 : 0
  connectivity_type = "private"
  subnet_id         = module.vpc.private_subnets[0]
}
resource "aws_route" "intra_subnets_default_gateway" {
  # count                  = local.vpc_cni_actived && local.vpc_cni_custom_enabled ? 1 : 0
  route_table_id         = module.vpc.intra_route_table_ids[0]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_nat.id
  depends_on             = [aws_nat_gateway.private_nat]
}
