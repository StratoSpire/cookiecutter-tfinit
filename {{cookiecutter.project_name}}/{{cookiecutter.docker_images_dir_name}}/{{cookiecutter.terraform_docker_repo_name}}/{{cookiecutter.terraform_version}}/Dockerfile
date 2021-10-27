ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}}
FROM {{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/{{cookiecutter.aws_cli_docker_repo_name}}:{{cookiecutter.aws_cli_version}}-${UBUNTU_RELEASE_NAME}

ARG TERRAFORM_VERSION="{{cookiecutter.terraform_version}}"
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

RUN export ARCH="$( dpkg --print-architecture )" && \
    curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip -o terraform.zip && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/local/bin

ARG TERRAFORM_DOCS_VERSION="{{cookiecutter.terraform_docs_version}}"
ENV TERRAFORM_DOCS_VERSION=${TERRAFORM_DOCS_VERSION}

RUN export ARCH="$( dpkg --print-architecture )" && \
    curl -L -O https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${ARCH}.tar.gz && \
    tar -xvzf terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${ARCH}.tar.gz && \
    mv terraform-docs /usr/local/bin/terraform-docs && \
    rm -rf terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${ARCH} && \
    terraform-docs version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
