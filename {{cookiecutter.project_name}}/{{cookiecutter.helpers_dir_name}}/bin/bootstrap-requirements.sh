#!/bin/bash

set -e

ADMIN_ROLE_NAME="{{cookiecutter.admin_role_name}}"

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${THIS_SCRIPT_DIR}/set-env-vars.sh"

# AdministratorAccess Role
aws cloudformation deploy \
--region "${AWS_DEFAULT_REGION}" \
--stack-name "${TFINIT_NAMESPACE}-ctinit-admin-role" \
--template-file "${TFINIT_HELPERS_FILES_DIR}/admin-role.yaml" \
--parameter-overrides "RoleName=${ADMIN_ROLE_NAME}" \
--capabilities "CAPABILITY_NAMED_IAM"

# Terraform Remote State Backend
aws cloudformation deploy \
--region "${AWS_DEFAULT_REGION}" \
--stack-name "${TFINIT_NAMESPACE}-ctinit-terraform-backend" \
--template-file "${TFINIT_HELPERS_FILES_DIR}/terraform-backend.yaml" \
--parameter "StateBackendName=${TFINIT_NAMESPACE}-terraform-backend"
