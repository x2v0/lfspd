#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in git make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning xxHash repository..."
if ! git clone https://github.com/Cyan4973/xxHash; then
    echo "Error: Failed to clone xxHash repository."
    exit 1
fi

# Enter the cloned directory
pushd xxHash || { echo "Error: Failed to enter directory xxHash."; exit 1; }

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of xxHash completed successfully."
