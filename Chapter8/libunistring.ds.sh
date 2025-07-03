#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation
export MAKEFLAGS="-j$(nproc)"

# Configure the build
./configure --prefix=/usr \
            --disable-static \
            --docdir=/usr/share/doc/libunistring-1.1

# Build and install
make
make install
