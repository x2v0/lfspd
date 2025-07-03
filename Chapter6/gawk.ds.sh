#!/bin/bash

# Exit on error
set -e

# Modify Makefile.in to remove 'extras'
echo "Modifying Makefile.in..."
sed -i 's/extras//' Makefile.in

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

echo "Installation complete!"
