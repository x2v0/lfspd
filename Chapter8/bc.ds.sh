#!/bin/bash

# Ensure the script stops on any error
set -e

# Optional: Use all available CPU cores for faster builds
MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# Configure the build with specific options
echo "Configuring the build..."
CC=gcc ./configure --prefix=/usr -G -O3 -r

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make install

# Success message
echo "Build and installation completed successfully."
