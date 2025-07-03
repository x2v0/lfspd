#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation (optional)
# export MAKEFLAGS="-j$(nproc)"

# Configure the build
./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.3 \
            --disable-static                        \
            --disable-kill                         \
            --without-ncurses

# Build and install
make
make install
