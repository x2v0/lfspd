#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Apply a patch to fix backspace behavior
patch -Np1 -i ../kbd-2.6.1-backspace-1.patch

# Disable RESIZECONS_PROGS in the configure script
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure

# Remove resizecons.8 from the man page Makefile
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

# Configure the software with specific options
./configure --prefix=/usr \  # Install to /usr
            --disable-vlock  # Disable the vlock utility

# Build and install the software
# Use `&&` to ensure `make install` only runs if `make` succeeds
make && make install
