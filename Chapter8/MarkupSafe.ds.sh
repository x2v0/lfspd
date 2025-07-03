#!/bin/bash

# Ensure the script stops on any error
set -e

# Build the package
echo "Building the package..."
python3 setup.py build

# Install the package
echo "Installing the package..."
python3 setup.py install

# Success message
echo "Build and installation completed successfully."
