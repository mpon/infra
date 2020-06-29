resource "aws_ecs_task_definition" "envoy" {
  family                = "envoy-${random_string.envoy.result}"
  container_definitions = file("${path.module}/task-definitions/envoy.json")
}

resource "aws_ecs_service" "envoy" {
  count           = local.envoy_service_count
  name            = random_pet.envoy_service.*.id[count.index]
  cluster         = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.envoy.arn
  desired_count   = random_integer.envoy_service.*.result[count.index]
}

# generate random

resource "random_string" "envoy" {
  length  = 6
  number  = false
  special = false
}

resource "random_pet" "envoy_service" {
  count = local.envoy_service_count
}

resource "random_integer" "envoy_service" {
  count = local.envoy_service_count
  min   = 1
  max   = 3
}