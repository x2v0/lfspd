#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess) \
  --enable-install-program=hostname \
  --enable-no-install-program=kill,uptime \
  gl_cv_macro_MB_CUR_MAX_good=y

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

# Move chroot to the correct location
echo "Moving chroot to /usr/sbin..."
mv -v "$LFS/usr/bin/chroot" "$LFS/usr/sbin"

# Create man8 directory if it doesn't exist
echo "Creating man8 directory..."
mkdir -pv "$LFS/usr/share/man/man8"

# Move chroot man page to man8
echo "Moving chroot man page..."
mv -v "$LFS/usr/share/man/man1/chroot.1" "$LFS/usr/share/man/man8/chroot.8"

# Update the man page section number
echo "Updating man page section number..."
sed -i 's/"1"/"8"/' "$LFS/usr/share/man/man8/chroot.8"

echo "Installation complete!"
