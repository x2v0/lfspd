#!/bin/bash

# Exit on error
set -e

# Create build directory
echo "Creating build directory..."
mkdir -v build
cd build

# Configure libstdc++
echo "Configuring libstdc++..."
../libstdc++-v3/configure \
  --host=$LFS_TGT \
  --build=$(../config.guess) \
  --prefix=/usr \
  --disable-multilib \
  --disable-nls \
  --disable-libstdcxx-pch \
  --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0

# Build libstdc++
echo "Building libstdc++..."
make

# Install libstdc++
echo "Installing libstdc++..."
make DESTDIR=$LFS install

# Remove unnecessary .la files
echo "Removing unnecessary .la files..."
rm -v "$LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la"

echo "libstdc++ installation complete!"
