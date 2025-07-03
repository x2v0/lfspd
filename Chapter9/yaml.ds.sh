#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Package details
PKG="libyaml"
PKG_VERSION="0.2"
PKG_BUILD="5"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/yaml/libyaml/releases/download/${PKG_VERSION}.${PKG_BUILD}/${PKG_FILE}"
MD5="bb15429d8fb787e7d3f1c83ae129a999"

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
if ! tar -xzf "$PKG_FILE"; then
    echo "Error: Failed to extract ${PKG_FILE}."
    exit 1
fi

# Enter the extracted directory
cd "$PKG_FULL" || { echo "Error: Failed to enter directory ${PKG_FULL}."; exit 1; }

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr/local --disable-static

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

echo "Installation of ${PKG_FULL} completed successfully."
