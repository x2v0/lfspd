#!/bin/bash

# Exit on error
set -e

# Create and enter build directory
echo "Creating build directory..."
mkdir -v build
pushd build

# Configure the build with specific libraries disabled
echo "Configuring the build (with some libraries disabled)..."
../configure \
  --disable-bzlib \
  --disable-libseccomp \
  --disable-xzlib \
  --disable-zlib

# Build the software
echo "Building the software..."
make

# Return to the original directory
popd

# Configure the main build
echo "Configuring the main build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(./config.guess)

# Build the software using the compiled 'file' utility from the build directory
echo "Building the software with FILE_COMPILE..."
make FILE_COMPILE=$(pwd)/build/src/file

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

# Remove unnecessary .la file
echo "Removing unnecessary .la file..."
rm -v "$LFS/usr/lib/libmagic.la"

echo "Installation complete!"
