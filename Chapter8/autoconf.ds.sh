#!/bin/bash

# Ensure the script stops on any error
set -e

# Optional: Use all available CPU cores for faster builds
MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# Modify the tests/local.at file
echo "Modifying tests/local.at..."
sed -e 's/SECONDS|/&SHLVL|/'               \
    -e '/BASH_ARGV=/a\        /^SHLVL=/ d' \
    -i.orig tests/local.at

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr

# Build and install the software
echo "Building and installing the software..."
make && make install

# Success message
echo "Build and installation completed successfully."
