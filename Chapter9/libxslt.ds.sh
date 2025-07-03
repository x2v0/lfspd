#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in make gcc python3; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr                         \
            --disable-static                      \
            --docdir=/usr/share/doc/libxslt-1.1.39 \
            PYTHON=/usr/bin/python3

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

echo "Installation completed successfully."
