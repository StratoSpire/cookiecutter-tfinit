#syntax=bergkvist/includeimage

FROM docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/buildpack-deps:{{cookiecutter.ubuntu_version_name}}
INCLUDE docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/aws-cli:{{cookiecutter.aws_cli_version}}-{{cookiecutter.ubuntu_version_name}}
INCLUDE docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/terraform:{{cookiecutter.terraform_version}}-{{cookiecutter.ubuntu_version_name}}
INCLUDE docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/terraform-docs:{{cookiecutter.terraform_docs_version}}-{{cookiecutter.ubuntu_version_name}}

ENV LD_LIBRARY_PATH="/usr/local/lib"

RUN aws --version && \
    terraform version && \
    terraform-docs version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
