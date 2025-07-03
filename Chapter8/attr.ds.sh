#!/bin/bash

# Ensure the script stops on any error
set -e

# Optional: Use all available CPU cores for faster builds
MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.1

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make install

# Success message
echo "Build and installation completed successfully."
