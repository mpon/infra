resource "random_pet" "cluster" {
}

resource "aws_ecs_cluster" "cluster" {
  name = random_pet.cluster.id
}

resource "aws_autoscaling_group" "cluster" {
  name                 = "ecs-cluster-${aws_ecs_cluster.cluster.name}"
  vpc_zone_identifier  = module.vpc.public_subnets
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.cluster.name

  tag {
    key                 = "Name"
    value               = "ecs-cluster-${aws_ecs_cluster.cluster.name}"
    propagate_at_launch = true
  }
}

data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

resource "aws_launch_configuration" "cluster" {
  name                        = "ecs-cluster-${aws_ecs_cluster.cluster.name}"
  image_id                    = jsondecode(data.aws_ssm_parameter.ecs_optimized_ami.value).image_id
  instance_type               = "m5.large"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_role.name

  security_groups = [module.vpc.default_security_group_id]
  user_data       = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    cluster = aws_ecs_cluster.cluster.name
  }
}
