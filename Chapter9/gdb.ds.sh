#!/bin/bash

# GDB, the GNU Project debugger, allows you to see what is going on "inside" another program
# while it executes -- or what another program was doing at the moment it crashed.

PKG="gdb"
PKG_VERSION="13.2"
PKG_FULL=${PKG}-${PKG_VERSION}
PKG_FILE="${PKG_FULL}.tar.xz"
URL="https://ftp.gnu.org/gnu/${PKG}/${PKG_FILE}"
MD5="fbd3cdae16c581e8a742cb766ba35076"

# Download the package
wget $URL

# Verify the MD5 checksum (optional but recommended)
echo "$MD5  $PKG_FILE" | md5sum -c -

# Extract the package
tar -xf $PKG_FILE

# Navigate into the extracted directory
pushd $PKG_FULL

# Create a build directory and navigate into it
mkdir -p build
pushd build

# Configure arguments
ARGS=" --prefix=/usr/local "
ARGS+=" --disable-shared"
ARGS+=" --disable-werror"
ARGS+=" --disable-nls"
ARGS+=" --disable-docs"
ARGS+=" --with-expat"
ARGS+=" --without-mpc"
ARGS+=" --without-mpfr"
ARGS+=" --without-gmp"
ARGS+=" --without-cloog"
ARGS+=" --without-isl"
ARGS+=" --disable-sim"
ARGS+=" --enable-gdbserver=no"

# Run the configure script
../configure --with-python=/usr/bin/python3 $ARGS

# Build and install
make -j$(nproc)
sudo make install

# Navigate back to the original directory
popd
popd
