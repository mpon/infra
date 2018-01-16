resource "aws_ecs_cluster" "cluster" {
  name = "sandbox"
}

module "ecs_autoscaling_group" "cluster" {
  source = "../modules/ecs_autoscaling_group"

  cluster_name     = "${aws_ecs_cluster.cluster.name}"
  key_name         = "${var.key_name}"
  cluster_size     = "2"
  instance_profile = "${var.instance_profile}"

  instance_security_groups = [
    "${module.base_network.sg_allow_vpc}",
  ]

  vpc_zone_identifier = [
    "${module.base_network.private_a_subnet_id}",
    "${module.base_network.private_c_subnet_id}",
  ]
}
