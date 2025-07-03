#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Package details
PKG="nasm"
PKG_VERSION="2.16.01"
PKG_FILE="${PKG}-${PKG_VERSION}.tar.xz"
URL="http://www.nasm.us/pub/${PKG}/releasebuilds/${PKG_VERSION}/${PKG_FILE}"
MD5="d755ba0d16f94616c2907f8cab7c748b"

# Check for necessary tools
for cmd in wget tar make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Download the package
echo "Downloading ${PKG_FILE}..."
if ! wget -q "$URL"; then
    echo "Error: Failed to download ${PKG_FILE}."
    exit 1
fi

# Verify the MD5 checksum
echo "Verifying MD5 checksum..."
if ! echo "${MD5}  ${PKG_FILE}" | md5sum -c -; then
    echo "Error: MD5 checksum verification failed for ${PKG_FILE}."
    exit 1
fi

# Extract the package
echo "Extracting ${PKG_FILE}..."
if ! tar -xJf "$PKG_FILE"; then
    echo "Error: Failed to extract ${PKG_FILE}."
    exit 1
fi

# Enter the extracted directory
cd "${PKG}-${PKG_VERSION}" || { echo "Error: Failed to enter directory ${PKG}-${PKG_VERSION}."; exit 1; }

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr/local

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

echo "Installation of ${PKG}-${PKG_VERSION} completed successfully."
