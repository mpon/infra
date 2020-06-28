locals {
  nginx_service_count = 5
  envoy_service_count = 7
}

# nginx service

resource "random_string" "nginx" {
  length  = 6
  number  = false
  special = false
}

resource "aws_ecs_task_definition" "nginx" {
  family                = "nginx-${random_string.nginx.result}"
  container_definitions = file("${path.module}/task-definitions/nginx.json")
}

resource "random_pet" "nginx_service" {
  count = local.nginx_service_count
}

resource "random_integer" "nginx_service" {
  count = local.nginx_service_count
  min   = 1
  max   = 3
}

resource "aws_ecs_service" "nginx" {
  count           = local.nginx_service_count
  name            = random_pet.nginx_service.*.id[count.index]
  cluster         = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = random_integer.nginx_service.*.result[count.index]
}

# envoy service

resource "random_string" "envoy" {
  length  = 6
  number  = false
  special = false
}

resource "aws_ecs_task_definition" "envoy" {
  family                = "envoy-${random_string.envoy.result}"
  container_definitions = file("${path.module}/task-definitions/envoy.json")
}

resource "random_pet" "envoy_service" {
  count = local.envoy_service_count
}

resource "random_integer" "envoy_service" {
  count = local.envoy_service_count
  min   = 1
  max   = 3
}

resource "aws_ecs_service" "envoy" {
  count           = local.envoy_service_count
  name            = random_pet.envoy_service.*.id[count.index]
  cluster         = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.envoy.arn
  desired_count   = random_integer.envoy_service.*.result[count.index]
}