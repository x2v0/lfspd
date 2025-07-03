#!/bin/bash

# Exit on error
set -e

# Clone jemalloc repository
git clone https://github.com/jemalloc/jemalloc.git
cd jemalloc

# Generate configure script and other build files
./autogen.sh

# Configure the build
./configure --prefix=/usr/local

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the jemalloc directory
cd ..
rm -rf jemalloc

echo "jemalloc installation completed successfully."
