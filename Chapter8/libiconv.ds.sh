#!/bin/bash

# Exit immediately if any command fails
set -e

# Define package details
PKG="libiconv"
PKG_VERSION="1.17"
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://ftp.gnu.org/pub/gnu/${PKG}/${PKG_FILE}"

# Download the source tarball
echo "Downloading ${PKG_FILE}..."
wget "${URL}"

# Extract the tarball
echo "Extracting ${PKG_FILE}..."
tar -xzf "${PKG_FILE}"

# Change to the extracted directory
cd "${PKG_FULL}"

# Configure the software with specific options
echo "Configuring ${PKG_FULL}..."
./configure --prefix=/usr  # Install to /usr

# Build the software
echo "Building ${PKG_FULL}..."
make

# Install the software
echo "Installing ${PKG_FULL}..."
make install

# Clean up
cd ..
rm -rf "${PKG_FULL}" "${PKG_FILE}"
echo "Installation of ${PKG_FULL} complete!"
