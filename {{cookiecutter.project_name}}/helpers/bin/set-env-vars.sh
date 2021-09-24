#!/bin/bash

set -e

export TFINIT_NAMESPACE="{{cookiecutter.namespace}}"

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export TFINIT_ROOT_DIR="$( cd ${THIS_SCRIPT_DIR}/../../ &> /dev/null && pwd )"
export TFINIT_HELPERS_BIN_DIR="${TFINIT_ROOT_DIR}/helpers/bin"
export TFINIT_HELPERS_FILES_DIR="${TFINIT_ROOT_DIR}/helpers/files"

export WRAP_AWS_BIN="${TFINIT_HELPERS_BIN_DIR}/wrap-aws.sh"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:=us-east-1}"
export AWS_PROFILE="${AWS_PROFILE:=AWSAdministratorAccess-{{cookiecutter.management_account_id}}}"
