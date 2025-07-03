#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --disable-static \
  --with-gcc-arch=native

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make install

echo "Installation complete!"
