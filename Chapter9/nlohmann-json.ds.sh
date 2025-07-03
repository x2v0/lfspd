#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Package details
PKG="json"
PKG_VERSION="3.11"
PKG_BUILD="2"
URL="https://github.com/nlohmann/${PKG}.git"

# Check for necessary tools
for cmd in git cmake make gcc; do
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

# Create and enter the build directory
echo "Creating and entering build directory..."
mkdir -p build
cd build || { echo "Error: Failed to enter build directory."; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ..

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of ${PKG} completed successfully."
