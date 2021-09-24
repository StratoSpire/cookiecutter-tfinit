#!/bin/bash

set -e

export TFINIT_NAMESPACE="{{cookiecutter.namespace}}"

export TFINIT_HELPERS_BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export TFINIT_ROOT_DIR="$( cd ${TFINIT_HELPERS_BIN_DIR}/../../ &> /dev/null && pwd )"

export TFINIT_HELPERS_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.helpers_dir_name}}"
export TFINIT_DEPLOYMENTS_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.deployments_dir_name}}"
export TFINIT_MODULES_DIR="${TFINIT_ROOT_DIR}/{{cookiecutter.modules_dir_name}}"
export TFINIT_HELPERS_FILES_DIR="${TFINIT_HELPERS_DIR}/files"

export WRAP_AWS_BIN="${TFINIT_HELPERS_BIN_DIR}/wrap-aws.sh"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:=us-east-1}"
export AWS_PROFILE="${AWS_PROFILE:=AWSAdministratorAccess-{{cookiecutter.management_account_id}}}"
