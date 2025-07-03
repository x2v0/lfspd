#!/bin/bash

# Ensure the script stops on any error
set -e

# Optional: Use all available CPU cores for faster builds
MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# Check for necessary tools
if ! command -v gcc &> /dev/null; then
    echo "gcc could not be found. Please install gcc."
    exit 1
fi

if ! command -v make &> /dev/null; then
    echo "make could not be found. Please install make."
    exit 1
fi

if ! command -v ./configure &> /dev/null; then
    echo "configure script could not be found. Ensure you are in the correct directory."
    exit 1
fi

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr         \
            --disable-static      \
            --docdir=/usr/share/doc/acl-2.3.1 > configure.log 2>&1

# Build the software
echo "Building the software..."
make > make.log 2>&1

# Install the software
echo "Installing the software..."
make install > make_install.log 2>&1

# Clean up intermediate files
echo "Cleaning up..."
make clean

# Success message
echo "Build and installation completed successfully."
