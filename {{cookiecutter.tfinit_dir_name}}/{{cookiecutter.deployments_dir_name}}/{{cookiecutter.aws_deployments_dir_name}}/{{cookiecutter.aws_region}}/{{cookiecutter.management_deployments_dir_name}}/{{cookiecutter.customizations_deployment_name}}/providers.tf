provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::{{cookiecutter.management_account_id}}:role/{{cookiecutter.admin_role_name}}"
    session_name = "tf_provider_management_{{cookiecutter.customizations_deployment_name}}"
  }
  region = "{{cookiecutter.aws_region}}"
}
