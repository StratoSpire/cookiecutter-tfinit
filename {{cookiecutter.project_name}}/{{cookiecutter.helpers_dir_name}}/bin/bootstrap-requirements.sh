#!/bin/bash

set -e

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${THIS_SCRIPT_DIR}/set-env-vars.sh"

# AdministratorAccess Role
aws cloudformation deploy \
    --region "${AWS_DEFAULT_REGION}" \
    --stack-name "${TFINIT_NAMESPACE}-tfinit-iam" \
    --template-file "${TFINIT_HELPERS_FILES_DIR}/tfinit-iam.yaml" \
    --parameter-overrides \
        UserName=${TFINIT_USER_NAME} \
        GroupName=${TFINIT_GROUP_NAME} \
        RoleName=${TFINIT_ROLE_NAME} \
    --capabilities "CAPABILITY_NAMED_IAM"

# Terraform Remote State Backend
aws cloudformation deploy \
    --region "${AWS_DEFAULT_REGION}" \
    --stack-name "${TFINIT_NAMESPACE}-tfinit-terraform-backend" \
    --template-file "${TFINIT_HELPERS_FILES_DIR}/tfinit-terraform-backend.yaml" \
    --parameter-overrides \
        StateBucketName=${TFINIT_STATE_BUCKET} \
        StateTableName=${TFINIT_STATE_TABLE}

# Login to ECR
aws ecr get-login-password \
    --region "${AWS_DEFAULT_REGION}" | \
        docker login \
        --username AWS \
        --password-stdin "${TFINIT_MANAGEMENT_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"

# Build and publish the Terraform image
cd "${TFINIT_DOCKER_IMAGES_DEPLOYMENT_DIR}"
terraform init
terraform apply -auto-approve -target module.docker_image_terraform

# Create the GitHub Actions secrets
cd "${TFINIT_GITHUB_ACTIONS_SECRETS_DEPLOYMENT_DIR}"
terraform init
terraform apply -auto-approve -var repository_name="${TFINIT_PROJECT_NAME}"
