#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Configure the build
./configure --prefix=/usr       \
            --sysconfdir=/etc   \
            --with-ssl=openssl

# Build and install
make
make install
