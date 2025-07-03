#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./config \
  --prefix=/usr \
  --openssldir=/etc/ssl \
  --libdir=lib \
  shared \
  zlib-dynamic

# Build the software
echo "Building the software..."
make

# Modify Makefile to exclude static libraries from installation
echo "Modifying Makefile..."
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile

# Install the software
echo "Installing the software..."
make MANSUFFIX=ssl install

echo "Installation complete!"
