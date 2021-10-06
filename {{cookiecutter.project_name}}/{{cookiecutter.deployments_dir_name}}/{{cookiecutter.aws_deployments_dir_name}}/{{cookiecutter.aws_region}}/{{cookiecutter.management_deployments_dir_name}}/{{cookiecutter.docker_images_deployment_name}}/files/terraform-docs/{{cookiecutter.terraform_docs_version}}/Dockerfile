ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}} \
    TERRAFORM_VERSION="{{cookiecutter.terraform_version}}"
FROM docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/terraform:${TERRAFORM_VERSION}-${UBUNTU_RELEASE_NAME}

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
