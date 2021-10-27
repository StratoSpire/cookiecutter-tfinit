ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}}
FROM {{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/{{cookiecutter.buildpack_deps_docker_repo_name}}:scm-${UBUNTU_RELEASE_NAME}

ARG AWS_CLI_VERSION="{{cookiecutter.aws_cli_version}}"
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

RUN export ARCH="$( uname -m )" && \
    curl -L https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}-${AWS_CLI_VERSION}.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    rm awscliv2.zip && \
    ./aws/install && \
    rm -rf ./aws && \
    aws --version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
