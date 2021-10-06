terraform {
  required_version = ">= {{cookiecutter.terraform_version}}"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> {{cookiecutter.github_provider_version}}"
    }
  }
}
