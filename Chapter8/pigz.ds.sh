#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Build the project
make

# Install the binary
cp -v pigz /usr/bin/
