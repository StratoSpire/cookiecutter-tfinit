terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> {{cookiecutter.aws_provider_version}}"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}
