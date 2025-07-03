#!/bin/bash

# Ensure the script stops on any error
set -e

# Build the package
python3 setup.py build

# Install the package
python3 setup.py install

# Optionally, you can add a message to indicate successful completion
echo "Build and installation completed successfully."
