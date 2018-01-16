# ecs_autoscaling_group

## usage

```hcl
module "ecs_autoscaling_group" "cluster" {
  source = "../modules/ecs_autoscaling_group"

  name             = "${aws_ecs_cluster.cluster.name}"
  key_name         = "${var.key_name}"
  cluster_size     = "2"
  instance_profile = "${var.instance_profile}"

  vpc_zone_identifier = [
    "${module.base_network.private_a_subnet_id}",
    "${module.base_network.private_c_subnet_id}",
  ]
}
```
