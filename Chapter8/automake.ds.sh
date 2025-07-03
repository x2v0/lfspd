#!/bin/bash

# Ensure the script stops on any error
set -e

# Optional: Use all available CPU cores for faster builds
MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

# Build and install the software
echo "Building and installing the software..."
make && make install

# Success message
echo "Build and installation completed successfully."
