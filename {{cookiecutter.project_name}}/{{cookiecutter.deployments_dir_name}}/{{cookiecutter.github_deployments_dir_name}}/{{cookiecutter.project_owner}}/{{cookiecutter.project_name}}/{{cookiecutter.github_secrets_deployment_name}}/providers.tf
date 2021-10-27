provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::{{cookiecutter.management_account_id}}:role/{{cookiecutter.admin_role_name}}"
    session_name = "tf_provider_management_{{cookiecutter.github_secrets_deployment_name}}"
  }
  region = "{{cookiecutter.aws_region}}"
}

provider "github" {
  token = var.github_token
  owner = "{{cookiecutter.project_owner}}"
}
