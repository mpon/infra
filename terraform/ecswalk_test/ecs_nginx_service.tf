resource "aws_ecs_task_definition" "nginx" {
  family                = "nginx-${random_string.nginx.result}"
  container_definitions = file("${path.module}/task-definitions/nginx.json")
}

resource "aws_ecs_service" "nginx" {
  count           = local.nginx_service_count
  name            = random_pet.nginx_service.*.id[count.index]
  cluster         = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = random_integer.nginx_service.*.result[count.index]
}

# generate random

resource "random_string" "nginx" {
  length  = 6
  number  = false
  special = false
}

resource "random_pet" "nginx_service" {
  count = local.nginx_service_count
}

resource "random_integer" "nginx_service" {
  count = local.nginx_service_count
  min   = 1
  max   = 3
}
