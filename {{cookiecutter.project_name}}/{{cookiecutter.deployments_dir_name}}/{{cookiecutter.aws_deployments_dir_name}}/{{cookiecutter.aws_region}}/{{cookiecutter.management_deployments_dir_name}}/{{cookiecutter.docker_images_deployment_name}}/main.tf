data "aws_ecr_authorization_token" "token" {}

provider "docker" {
  registry_auth {
    address  = "{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com"
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}

module "docker_image_ubuntu" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.ubuntu_docker_repo_name}}"
  tags        = ["{{cookiecutter.ubuntu_version_name}}", "latest"]
  source_path = abspath("${path.module}/files/ubuntu/{{cookiecutter.ubuntu_version_name}}")
}

module "docker_image_buildpack_deps_curl" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.buildpack_deps_docker_repo_name}}-curl"
  tags        = ["{{cookiecutter.ubuntu_version_name}}", "latest"]
  source_path = abspath("${path.module}/files/buildpack-deps/curl/{{cookiecutter.ubuntu_version_name}}")

  depends_on = [module.docker_image_ubuntu]
}

module "docker_image_buildpack_deps_scm" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.buildpack_deps_docker_repo_name}}-scm"
  tags        = ["{{cookiecutter.ubuntu_version_name}}", "latest"]
  source_path = abspath("${path.module}/files/buildpack-deps/scm/{{cookiecutter.ubuntu_version_name}}")

  depends_on = [module.docker_image_buildpack_deps_curl]
}

module "docker_image_buildpack_deps" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.buildpack_deps_docker_repo_name}}"
  tags        = ["{{cookiecutter.ubuntu_version_name}}", "latest"]
  source_path = abspath("${path.module}/files/buildpack-deps/{{cookiecutter.ubuntu_version_name}}")

  depends_on = [module.docker_image_buildpack_deps_scm]
}

module "docker_image_aws_cli" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.aws_cli_docker_repo_name}}"
  tags        = ["{{cookiecutter.aws_cli_version}}", "latest"]
  source_path = abspath("${path.module}/files/aws-cli/{{cookiecutter.aws_cli_version}}")

  depends_on = [module.docker_image_buildpack_deps_scm]
}

module "docker_image_terraform" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.terraform_docker_repo_name}}"
  tags        = ["{{cookiecutter.terraform_version}}", "latest"]
  source_path = abspath("${path.module}/files/terraform/{{cookiecutter.terraform_version}}")

  depends_on = [module.docker_image_buildpack_deps_scm]
}

module "docker_image_terraform_docs" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.terraform_docs_docker_repo_name}}"
  tags        = ["{{cookiecutter.terraform_docs_version}}", "latest"]
  source_path = abspath("${path.module}/files/terraform-docs/{{cookiecutter.terraform_docs_version}}")

  depends_on = [module.docker_image_terraform]
}

module "docker_image_ci" {
  source = "../../../../../modules/docker-image"

  name        = "{{cookiecutter.ci_docker_repo_name}}"
  tags        = ["latest"]
  source_path = abspath("${path.module}/files/terraform/latest")

  depends_on = [
    module.docker_image_buildpack_deps,
    module.docker_image_aws_cli,
    module.docker_image_terraform,
    module.docker_image_terraform_docs
  ]
}
