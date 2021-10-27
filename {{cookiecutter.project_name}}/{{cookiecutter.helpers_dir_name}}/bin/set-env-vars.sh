#!/usr/bin/env bash

set -eo pipefail

export TFINIT_NAMESPACE="{{cookiecutter.namespace}}"

export TFINIT_HELPERS_BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export TFINIT_ROOT_DIR="$( cd ${TFINIT_HELPERS_BIN_DIR}/../../ &> /dev/null && pwd )"

export TFINIT_PROJECT_OWNER="{{cookiecutter.project_owner}}"
export TFINIT_PROJECT_NAME="{{cookiecutter.project_name}}"
export TFINIT_HELPERS_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.helpers_dir_name}}"
export TFINIT_DEPLOYMENTS_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.deployments_dir_name}}"
export TFINIT_MODULES_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.modules_dir_name}}"
export TFINIT_HELPERS_FILES_DIR="${TFINIT_HELPERS_DIR}/files"
export TFINIT_DOCKER_IMAGES_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.docker_images_dir_name}}"
export TFINIT_USER_NAME="{{cookiecutter.admin_user_name}}"
export TFINIT_GROUP_NAME="{{cookiecutter.admin_group_name}}"
export TFINIT_ROLE_NAME="{{cookiecutter.admin_role_name}}"
export TFINIT_STATE_BUCKET="{{cookiecutter.tf_state_bucket}}"
export TFINIT_STATE_TABLE="{{cookiecutter.tf_state_table}}"
export TFINIT_MANAGEMENT_ACCOUNT_ID="{{cookiecutter.management_account_id}}"
export TFINIT_AWS_DEPLOYMENTS_DIR="${TFINIT_DEPLOYMENTS_DIR}/{{cookiecutter.aws_deployments_dir_name}}"
export TFINIT_AWS_REGIONED_DEPLOYMENTS_DIR="${TFINIT_AWS_DEPLOYMENTS_DIR}/{{cookiecutter.aws_region}}"
export TFINIT_MANAGEMENT_DEPLOYMENTS_DIR="${TFINIT_AWS_REGIONED_DEPLOYMENTS_DIR}/{{cookiecutter.management_deployments_dir_name}}"
export TFINIT_CUSTOMIZATIONS_DEPLOYMENTS_DIR="${TFINIT_MANAGEMENT_DEPLOYMENTS_DIR}/{{cookiecutter.customizations_deployment_name}}"
export TFINIT_GITHUB_DEPLOYMENTS_DIR="${TFINIT_DEPLOYMENTS_DIR}/{{cookiecutter.github_deployments_dir_name}}"
export TFINIT_GITHUB_ACTIONS_SECRETS_DEPLOYMENT_DIR="${TFINIT_GITHUB_DEPLOYMENTS_DIR}/{{cookiecutter.project_owner}}/{{cookiecutter.project_name}}/{{cookiecutter.github_secrets_deployment_name}}"
export TFINIT_ECR_REGISTRY="${TFINIT_MANAGEMENT_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"

export WRAP_AWS_BIN="${TFINIT_HELPERS_BIN_DIR}/wrap-aws.sh"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:=us-east-1}"
export AWS_PROFILE="${AWS_PROFILE:=AWSAdministratorAccess-{{cookiecutter.management_account_id}}}"
