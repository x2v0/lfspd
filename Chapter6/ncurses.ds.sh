#!/bin/bash

# Exit on error
set -e

# Modify the configure script
echo "Modifying the configure script..."
sed -i 's/mawk//' configure

# Create and enter build directory
echo "Creating build directory..."
mkdir -v build
pushd build

# Configure and build necessary components
echo "Configuring and building components..."
../configure
make -C include
make -C progs tic

# Return to the original directory
popd

# Configure the main build
echo "Configuring the main build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(./config.guess) \
  --mandir=/usr/share/man \
  --with-manpage-format=normal \
  --with-shared \
  --without-normal \
  --with-cxx-shared \
  --without-debug \
  --without-ada \
  --disable-stripping \
  --enable-widec

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install

# Create a symbolic link for libncurses.so
echo "Creating symbolic link for libncurses.so..."
echo "INPUT(-lncursesw)" > "$LFS/usr/lib/libncurses.so"

echo "Installation complete!"
