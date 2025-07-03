#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess) \
  --disable-static \
  --docdir=/usr/share/doc/xz-5.4.4

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

# Remove unnecessary .la file
echo "Removing unnecessary .la file..."
rm -v "$LFS/usr/lib/liblzma.la"

echo "Installation complete!"
