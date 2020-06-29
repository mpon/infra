terraform {
  required_version = ">= 0.12.28"
}

provider "aws" {
  region = "ap-northeast-1"
}

locals {
  cluster_size        = 1
  nginx_service_count = 5
  envoy_service_count = 7
}
