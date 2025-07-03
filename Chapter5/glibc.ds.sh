#!/bin/bash

# Exit on error
set -e

# Create necessary symlinks based on architecture
case $(uname -m) in
  i?86)
    echo "Creating symlink for i386 architecture..."
    ln -sfv ld-linux.so.2 "$LFS/lib/ld-lsb.so.3"
    ;;
  x86_64)
    echo "Creating symlinks for x86_64 architecture..."
    ln -sfv ../lib/ld-linux-x86-64.so.2 "$LFS/lib64"
    ln -sfv ../lib/ld-linux-x86-64.so.2 "$LFS/lib64/ld-lsb-x86-64.so.3"
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

# Apply FHS patch
echo "Applying FHS patch..."
patch -Np1 -i ../glibc-2.38-fhs-1.patch

# Create build directory
echo "Creating build directory..."
mkdir -v build
cd build

# Set configuration parameters
echo "Setting configuration parameters..."
echo "rootsbindir=/usr/sbin" > configparms

# Configure glibc
echo "Configuring glibc..."
../configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(../scripts/config.guess) \
  --enable-kernel=4.14 \
  --with-headers=$LFS/usr/include \
  libc_cv_slibdir=/usr/lib

# Build glibc
echo "Building glibc..."
make

# Install glibc
echo "Installing glibc..."
make DESTDIR=$LFS install

# Fix ldd script
echo "Fixing ldd script..."
sed '/RTLDLIST=/s@/usr@@g' -i "$LFS/usr/bin/ldd"

echo "Glibc installation complete!"
