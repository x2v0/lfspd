#!/bin/bash

# Exit on error
set -e

# Download FastJet tarball
wget https://fastjet.fr/repo/fastjet-3.4.2.tar.gz

# Extract the tarball
tar -xzf fastjet-3.4.2.tar.gz

# Enter the FastJet directory
cd fastjet-3.4.2

# Configure the build
./configure --prefix=/usr/local

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the tarball and extracted directory
cd ..
rm -rf fastjet-3.4.2 fastjet-3.4.2.tar.gz

echo "FastJet installation completed successfully."
