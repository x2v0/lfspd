#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in git cmake make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning vdt repository..."
if ! git clone https://github.com/dpiparo/vdt.git; then
    echo "Error: Failed to clone vdt repository."
    exit 1
fi

# Enter the cloned directory
pushd vdt || { echo "Error: Failed to enter directory vdt."; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of vdt completed successfully."
