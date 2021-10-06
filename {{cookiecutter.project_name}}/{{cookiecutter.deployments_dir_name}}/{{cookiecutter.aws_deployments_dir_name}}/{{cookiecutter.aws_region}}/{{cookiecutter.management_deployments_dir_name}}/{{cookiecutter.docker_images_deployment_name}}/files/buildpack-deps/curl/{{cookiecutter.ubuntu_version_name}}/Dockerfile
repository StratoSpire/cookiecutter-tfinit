ARG UBUNTU_RELEASE_NAME={{cookiecutter.ubuntu_version_name}}
FROM docker.io/{{cookiecutter.management_account_id}}.dkr.ecr.{{cookiecutter.aws_region}}.amazonaws.com/{{cookiecutter.ubuntu_docker_repo_name}}:${UBUNTU_RELEASE_NAME}

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		jq \
		netbase \
		wget \
		unzip \
	&& rm -rf /var/lib/apt/lists/*

RUN set -ex; \
	if ! command -v gpg > /dev/null; then \
		apt-get update; \
		apt-get install -y --no-install-recommends \
			gnupg \
			dirmngr \
		; \
		rm -rf /var/lib/apt/lists/*; \
	fi
