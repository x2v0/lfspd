#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Remove crypt* files from the man3 directory
rm -v man3/crypt*

# Install the software with the specified prefix
make prefix=/usr install
