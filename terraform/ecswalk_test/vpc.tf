locals {
  cidr = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecswalk-test-vpc"
  cidr = local.cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = [cidrsubnet(local.cidr, 8, 1), cidrsubnet(local.cidr, 8, 2), cidrsubnet(local.cidr, 8, 3)]
  private_subnets = []

  enable_nat_gateway = false
  enable_vpn_gateway = false
}
