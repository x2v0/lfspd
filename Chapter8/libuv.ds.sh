#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation
export MAKEFLAGS="-j$(nproc)"

# Run autogen.sh to generate the configure script
sh autogen.sh

# Configure the build
./configure --prefix=/usr \
            --disable-static

# Build and install
make
make install
