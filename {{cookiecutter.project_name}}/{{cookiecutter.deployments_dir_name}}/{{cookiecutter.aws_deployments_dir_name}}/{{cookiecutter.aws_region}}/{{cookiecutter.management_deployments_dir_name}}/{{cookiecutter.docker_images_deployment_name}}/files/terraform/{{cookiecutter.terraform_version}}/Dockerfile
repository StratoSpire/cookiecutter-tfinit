ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}}
FROM docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/{{cookiecutter.buildpack_deps_docker_repo_name}}-scm:${UBUNTU_RELEASE_NAME}

ARG TERRAFORM_VERSION="{{cookiecutter.terraform_version}}"
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

RUN export ARCH="$( dpkg --print-architecture )" && \
    curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip -o terraform.zip && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
