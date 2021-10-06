locals {
  repository_name = "{{cookiecutter.project_name}}"
}

data "aws_cloudformation_stack" "tfinit_iam" {
  name = "{{cookiecutter.namespace}}-tfinit-iam"
}

data "aws_secretsmanager_secret" "tfinit_iam" {
  arn = data.aws_cloudformation_stack.tfinit_iam.outputs["SecretsManagerUserKeyArn"]
}

data "aws_secretsmanager_secret_version" "tfinit_iam" {
  secret_id = data.aws_secretsmanager_secret.tfinit_iam.id
}

resource "github_actions_secret" "access_key_id" {
  repository      = local.repository_name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = jsondecode(data.aws_secretsmanager_secret_version.tfinit_iam.secret_string)["access-key-id"]
}

resource "github_actions_secret" "secret_access_key" {
  repository      = local.repository_name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = jsondecode(data.aws_secretsmanager_secret_version.tfinit_iam.secret_string)["secret-access-key"]
}
