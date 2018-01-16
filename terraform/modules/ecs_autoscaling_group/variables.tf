variable "cluster_name" {}
variable "key_name" {}
variable "cluster_size" {}

variable "ecs_optimized_ami_id" {
  description = "if you use default value, set the latest ami"
  default     = ""
}

variable "instance_profile" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "vpc_zone_identifier" {
  type = "list"
}

variable "instance_security_groups" {
  type = "list"
}
