#!/bin/bash

# gperf is a perfect hash function generator.
# For a given list of strings, it produces a hash function and hash table,
# in form of C or C++ code, for looking up a value depending on the input string.
# The hash function is perfect, which means that the hash table has no collisions,
# and the hash table lookup needs a single string comparison only.

PKG="gperf"
PKG_VERSION="3.1"
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="http://ftp.gnu.org/pub/gnu/${PKG}/${PKG_FILE}"
MD5=""  # Add the MD5 checksum if available for verification

# Download the package
if ! wget "$URL"; then
    echo "Failed to download $PKG_FILE. Please check the URL and try again."
    exit 1
fi

# Verify the MD5 checksum (optional but recommended if MD5 is provided)
if [[ -n "$MD5" ]]; then
    if ! echo "$MD5  $PKG_FILE" | md5sum -c -; then
        echo "MD5 checksum verification failed. The downloaded file may be corrupted."
        exit 1
    fi
fi

# Extract the package
if ! tar -xzf "$PKG_FILE"; then
    echo "Failed to extract $PKG_FILE. Please check the file and try again."
    exit 1
fi

# Navigate into the extracted directory
cd "$PKG_FULL" || {
    echo "Failed to enter directory $PKG_FULL. Please check the extraction."
    exit 1
}

# Configure the build
if ! ./configure --prefix=/usr/local; then
    echo "Configuration failed. Please check the dependencies and try again."
    exit 1
fi

# Build the project
if ! make -j$(nproc); then
    echo "Build failed. Please check the errors and try again."
    exit 1
fi

# Install the built files (with sudo for necessary permissions)
if ! sudo make install; then
    echo "Installation failed. Please check the permissions and try again."
    exit 1
fi

# Navigate back to the original directory
cd .. || {
    echo "Failed to return to the original directory."
    exit 1
}

# Clean up by removing the extracted directory
rm -rf "$PKG_FULL"

echo "gperf installation completed successfully."
