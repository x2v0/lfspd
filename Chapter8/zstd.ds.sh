#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation (optional)
# export MAKEFLAGS="-j$(nproc)"

# Build the software
make prefix=/usr

# Install the software
make prefix=/usr install

# Remove the static library to save space
rm -v /usr/lib/libzstd.a
