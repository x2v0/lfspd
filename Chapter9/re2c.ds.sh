#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Repository URL
URL="https://github.com/skvadrik/re2c"

# Check for necessary tools
for cmd in git cmake make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning re2c repository..."
if ! git clone "$URL"; then
    echo "Error: Failed to clone re2c repository."
    exit 1
fi

# Enter the cloned directory
pushd re2c || { echo "Error: Failed to enter directory re2c."; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_STATIC_LIBS=OFF \
      -DBUILD_SHARED_LIBS=ON .

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of re2c completed successfully."
