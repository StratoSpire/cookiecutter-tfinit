#!/bin/bash

set -e -o pipefail

REPO_NAME="${1}"
REPO_BRANCH="${2}"
CONFIG_CHECKSUM="${3}"
CONFIG_DIRECTORY="${4}"
GIT_NAME="${5}"
GIT_EMAIL="${6}"
GIT_MESSAGE="${7}"
EPOCH="$(date +%s)"

TMP_DIR_PATH="/tmp/git_${REPO_NAME}_${REPO_BRANCH}_${CONFIG_CHECKSUM}_${EPOCH}"

function cleanup {
    rm -rf "${TMP_DIR_PATH}"
}
trap cleanup EXIT

# set git config
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

# clone the existing repo
git clone --depth=1 --single-branch --branch "${REPO_BRANCH}" "https://git-codecommit.${AWS_DEFAULT_REGION}.amazonaws.com/v1/repos/${REPO_NAME}" "${TMP_DIR_PATH}"

# make desired changes
cd "${TMP_DIR_PATH}"
rm -rf *
cp -a ${CONFIG_DIRECTORY}/* .
if [ -n "$(git diff --exit-code)" ]; then
    set -e
    echo "committing changes";
    git config user.name "${GIT_NAME}"
    git config user.email "${GIT_EMAIL}"
    git add -A
    git commit -m "${GIT_MESSAGE}"
    git push origin ${REPO_BRANCH}
else
    set -e
    echo "no changes to commit";
fi
