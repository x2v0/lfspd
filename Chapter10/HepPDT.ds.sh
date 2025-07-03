#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Configure the build
echo "Configuring build..."
./configure --prefix=/usr/local

# Build the software
echo "Building software..."
make

# Install the software
echo "Installing software..."
make install

echo "Installation completed successfully!"
