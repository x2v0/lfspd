#!/bin/bash

# Exit on error
set -e

# Extract and prepare dependencies
echo "Extracting and preparing dependencies..."
tar -xf ../mpfr-4.2.0.tar.xz
mv -v mpfr-4.2.0 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# Apply architecture-specific patches
case $(uname -m) in
  x86_64)
    echo "Applying x86_64-specific patch..."
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
    ;;
esac

# Fix thread header configuration
echo "Fixing thread header configuration..."
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
  -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

# Create and enter build directory
echo "Creating build directory..."
mkdir -v build
cd build

# Configure GCC
echo "Configuring GCC..."
../configure \
  --build=$(../config.guess) \
  --host=$LFS_TGT \
  --target=$LFS_TGT \
  LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
  --prefix=/usr \
  --with-build-sysroot=$LFS \
  --enable-default-pie \
  --enable-default-ssp \
  --disable-nls \
  --disable-multilib \
  --disable-libatomic \
  --disable-libgomp \
  --disable-libquadmath \
  --disable-libsanitizer \
  --disable-libssp \
  --disable-libvtv \
  --enable-languages=c,c++

# Build GCC
echo "Building GCC..."
make

# Install GCC
echo "Installing GCC..."
make DESTDIR=$LFS install

# Create a symlink for cc
echo "Creating symlink for cc..."
ln -sv gcc "$LFS/usr/bin/cc"

echo "GCC installation complete!"
