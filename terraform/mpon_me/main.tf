terraform {
  required_version = ">= 0.12.28"
  backend "s3" {
    key    = "mpon-me/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  version = "~> 2.68"
}
