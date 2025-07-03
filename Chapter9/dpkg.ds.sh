#!/bin/bash

set -e  # Exit immediately if any command fails

# Configure the project
echo "Configuring the project..."
./configure --prefix=/usr/local \
            --disable-start-stop-daemon \
            --disable-nls \
            --disable-rpath \
            --disable-update-alternatives \
            --disable-dselect || { echo "Configuration failed"; exit 1; }

# Build the project
echo "Building the project..."
make || { echo "Build failed"; exit 1; }

# Install the project
echo "Installing the project..."
sudo make install || { echo "Installation failed"; exit 1; }

echo "Script completed successfully!"
