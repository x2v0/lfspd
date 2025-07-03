#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --docdir=/usr/share/doc/bison-3.8.2

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make install

echo "Installation complete!"
