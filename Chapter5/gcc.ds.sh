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

# Create build directory
echo "Creating build directory..."
mkdir -v build
cd build

# Configure GCC
echo "Configuring GCC..."
../configure \
  --target=$LFS_TGT \
  --prefix=$LFS/tools \
  --with-glibc-version=2.38 \
  --with-sysroot=$LFS \
  --with-newlib \
  --without-headers \
  --enable-default-pie \
  --enable-default-ssp \
  --disable-nls \
  --disable-shared \
  --disable-multilib \
  --disable-threads \
  --disable-libatomic \
  --disable-libgomp \
  --disable-libquadmath \
  --disable-libssp \
  --disable-libvtv \
  --disable-libstdcxx \
  --enable-languages=c,c++

# Build and install GCC
echo "Building and installing GCC..."
make
make install

# Fix limits.h
echo "Fixing limits.h..."
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

echo "GCC build and installation complete!"
