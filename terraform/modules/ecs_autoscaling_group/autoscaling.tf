resource "aws_autoscaling_group" "cluster" {
  name                 = "ecs-cluster-${var.cluster_name}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]
  min_size             = "${var.cluster_size}"
  max_size             = "${var.cluster_size}"
  desired_capacity     = "${var.cluster_size}"
  launch_configuration = "${aws_launch_configuration.instance.name}"

  tag {
    key                 = "Name"
    value               = "ecs-cluster-${var.cluster_name}"
    propagate_at_launch = true
  }
}

data "aws_ami" "amzn_ecs_optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*.d-amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_launch_configuration" "instance" {
  name                        = "ecs-cluster-${var.cluster_name}"
  image_id                    = "${coalesce(var.ecs_optimized_ami_id, data.aws_ami.amzn_ecs_optimized.id)}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = false

  security_groups = [
    "${var.instance_security_groups}",
  ]

  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.instance_profile}"
  user_data            = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh")}"

  vars {
    cluster = "${var.cluster_name}"
  }
}
