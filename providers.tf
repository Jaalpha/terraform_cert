terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.36.0, <=6.38.0, !=6.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
  required_version = "~>1.14.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}
