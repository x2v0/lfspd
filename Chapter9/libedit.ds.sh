#!/bin/bash

# This is an autotool- and libtoolized port of the NetBSD Editline library (libedit).
# This Berkeley-style licensed command line editor library provides generic line editing,
# history, and tokenization functions, similar to those found in GNU Readline.

PKG="libedit"
PKG_VERSION="3.1"
PKG_BUILD="20230828"
PKG_FULL=${PKG}-${PKG_VERSION}-${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://www.thrysoee.dk/${PKG}/${PKG_FILE}"

# Check if the tarball already exists
if [ ! -f "$PKG_FILE" ]; then
    echo "Downloading $PKG_FILE..."
    wget "$URL" || { echo "Failed to download $PKG_FILE"; exit 1; }
fi

# Extract the tarball
if [ ! -d "$PKG_FULL" ]; then
    echo "Extracting $PKG_FILE..."
    tar -xzf "$PKG_FILE" || { echo "Failed to extract $PKG_FILE"; exit 1; }
fi

# Change to the extracted directory
cd "$PKG_FULL" || { echo "Failed to enter directory $PKG_FULL"; exit 1; }

# Configure, make, and install
echo "Configuring $PKG_FULL..."
./configure --prefix=/usr --disable-static || { echo "Configuration failed"; exit 1; }

echo "Building $PKG_FULL..."
make || { echo "Build failed"; exit 1; }

echo "Installing $PKG_FULL..."
sudo make install || { echo "Installation failed"; exit 1; }

echo "Installation of $PKG_FULL complete."
