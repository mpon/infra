variable "vpc_cidr_block" {
  default = "10.5.28.0/22"
}

module "base_network" {
  source = "../modules/base_network"

  name = "my-vpc"

  cidr_block {
    vpc       = "${var.vpc_cidr_block}"
    public_a  = "${cidrsubnet("${var.vpc_cidr_block}", 2, 0)}"
    public_c  = "${cidrsubnet("${var.vpc_cidr_block}", 2, 1)}"
    private_a = "${cidrsubnet("${var.vpc_cidr_block}", 2, 2)}"
    private_c = "${cidrsubnet("${var.vpc_cidr_block}", 2, 3)}"
  }
}
