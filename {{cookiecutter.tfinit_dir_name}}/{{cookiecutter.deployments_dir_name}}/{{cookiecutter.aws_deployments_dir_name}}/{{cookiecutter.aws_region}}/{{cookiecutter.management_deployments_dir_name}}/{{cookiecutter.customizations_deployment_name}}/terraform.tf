terraform {
  backend "s3" {
    bucket         = "{{cookiecutter.tf_state_bucket}}"
    dynamodb_table = "{{cookiecutter.tf_state_table}}"
    key            = "{{cookiecutter.aws_region}}/management/controltower-customizations/terraform.tfstate"
    region         = "{{cookiecutter.aws_region}}"
    role_arn       = "arn:aws:iam::{{cookiecutter.management_account_id}}:role/PlatformAdmin"
    session_name   = "tf_backend_management_{{cookiecutter.customizations_deployment_name}}"
  }
}
