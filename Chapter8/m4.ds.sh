#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation (optional)
# export MAKEFLAGS="-j$(nproc)"

# Configure the build with specific CFLAGS
CFLAGS="-Wno-error" ./configure --prefix=/usr

# Build and install
make
make install
