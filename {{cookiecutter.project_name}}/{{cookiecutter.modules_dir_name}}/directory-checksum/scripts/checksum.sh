#!/bin/bash
#
# This script calculates the MD5 checksum on a directory, run npm install, and create an archive.
#

# Exit if any of the intermediate steps fail
set -e

# Extract "DIRECTORY" argument from the input into
# DIRECTORY shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "DIRECTORY=\(.directory)"')"

cd "${DIRECTORY}"
CHECKSUM=`find . -type f | LC_ALL=C sort | xargs shasum -a 256 | awk '{ n=split ($2, tokens, /\//); print $1 " " tokens[n]} ' |  shasum -a 256 | awk '{ print $1 }'`

jq -n --arg checksum "$CHECKSUM" '{"checksum":$checksum}'
