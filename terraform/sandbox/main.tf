terraform {
  required_version = "0.11.2"

  backend "s3" {
    bucket = "mpon-infra"
    key    = "sandbox/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  version = "~> 1.7.0"
}

provider "template" {
  version = "~> 1.0.0"
}
