terraform {
  backend "s3" {
    bucket         = "{{cookiecutter.tf_state_bucket}}"
    dynamodb_table = "{{cookiecutter.tf_state_table}}"
    key            = "aws/{{cookiecutter.aws_region}}/management/{{cookiecutter.ecr_repositories_deployment_name}}/terraform.tfstate"
    region         = "{{cookiecutter.aws_region}}"
    role_arn       = "arn:aws:iam::{{cookiecutter.management_account_id}}:role/{{cookiecutter.admin_role_name}}"
    session_name   = "tf_backend_management_{{cookiecutter.ecr_repositories_deployment_name}}"
  }
}
