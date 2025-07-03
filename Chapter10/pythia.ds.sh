#!/bin/bash

# Exit on error
set -e

# Download Pythia tarball
wget https://pythia.org/download/pythia83/pythia8310.tgz

# Extract the tarball
tar -xzf pythia8310.tgz

# Enter the Pythia directory
cd pythia8310

# Configure the build
./configure --prefix=/usr/local

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the tarball and extracted directory
cd ..
rm -rf pythia8310 pythia8310.tgz

echo "Pythia installation completed successfully."
