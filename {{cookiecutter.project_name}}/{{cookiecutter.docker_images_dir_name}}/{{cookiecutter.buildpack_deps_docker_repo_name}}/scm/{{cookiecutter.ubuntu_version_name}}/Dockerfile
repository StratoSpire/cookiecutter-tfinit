ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}}
FROM {{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/{{cookiecutter.buildpack_deps_docker_repo_name}}:curl-${UBUNTU_RELEASE_NAME}

# procps is very common in build systems, and is a reasonably small package
RUN apt-get update && apt-get install -y --no-install-recommends \
		bzr \
		git \
		mercurial \
		openssh-client \
		subversion \
		\
		procps \
	&& rm -rf /var/lib/apt/lists/*
