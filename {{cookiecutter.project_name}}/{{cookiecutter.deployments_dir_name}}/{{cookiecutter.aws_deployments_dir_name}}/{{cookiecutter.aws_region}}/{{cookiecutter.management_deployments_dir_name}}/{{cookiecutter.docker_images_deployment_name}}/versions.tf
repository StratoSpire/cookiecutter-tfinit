terraform {
  required_version = ">= {{cookiecutter.terraform_version}}"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> {{cookiecutter.aws_provider_version}}"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= {{cookiecutter.docker_provider_version}}"
    }
  }
}
