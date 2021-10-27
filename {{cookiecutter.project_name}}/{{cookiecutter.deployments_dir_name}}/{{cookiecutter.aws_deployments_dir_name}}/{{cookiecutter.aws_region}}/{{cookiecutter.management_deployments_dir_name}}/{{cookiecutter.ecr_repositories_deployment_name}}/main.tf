locals {
    repositories = [
        "{{cookiecutter.ubuntu_docker_repo_name}}",
        "{{cookiecutter.buildpack_deps_docker_repo_name}}",
        "{{cookiecutter.aws_cli_docker_repo_name}}",
        "{{cookiecutter.terraform_docker_repo_name}}"
    ]
}

resource "aws_ecr_repository" "repositories" {
  count = length(local.repositories)

  name                 = local.repositories[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = {{cookiecutter.ecr_scan_on_push}}
  }
}
