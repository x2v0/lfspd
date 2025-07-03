#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Package details
PKG="lz4"
PKG_VERSION="1.9"
PKG_BUILD="5"
URL="https://github.com/${PKG}/${PKG}.git"

# Check for necessary tools
for cmd in git make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning ${PKG} repository..."
if ! git clone "$URL"; then
    echo "Error: Failed to clone ${PKG} repository."
    exit 1
fi

# Enter the cloned directory
pushd "$PKG" || { echo "Error: Failed to enter directory ${PKG}."; exit 1; }

# Build the project
echo "Building ${PKG}..."
if ! make; then
    echo "Error: Failed to build ${PKG}."
    exit 1
fi

# Install the project
echo "Installing ${PKG}..."
if ! make install; then
    echo "Error: Failed to install ${PKG}."
    exit 1
fi

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of ${PKG} completed successfully."
