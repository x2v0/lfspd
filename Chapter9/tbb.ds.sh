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
echo "Cloning oneTBB repository..."
if ! git clone https://github.com/oneapi-src/oneTBB.git; then
    echo "Error: Failed to clone oneTBB repository."
    exit 1
fi

# Enter the cloned directory
cd oneTBB || { echo "Error: Failed to enter directory oneTBB."; exit 1; }

# Create and enter the build directory
echo "Creating and entering build directory..."
mkdir -p build
cd build || { echo "Error: Failed to enter build directory."; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DTBB_TEST=OFF ..

# Build the project
echo "Building the project..."
cmake --build .

# Install the project
echo "Installing the project..."
cmake --install .

# Return to the original directory
cd ../.. || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of oneTBB completed successfully."
