#!/bin/bash

# Exit on error
set -e

# Configure the build
./configure --prefix=/usr \
            --enable-mt   \
            --with-rmt=/usr/libexec/rmt

# Build and install
make -j$(nproc)
sudo make install

echo "Installation completed successfully."
