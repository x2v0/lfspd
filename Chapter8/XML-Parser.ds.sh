#!/bin/bash

# Ensure the script stops on any error
set -e

# Generate the Makefile
echo "Generating the Makefile..."
perl Makefile.PL

# Build and install the software
echo "Building and installing the software..."
make && make install

# Success message
echo "Build and installation completed successfully."
