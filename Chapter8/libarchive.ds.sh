#!/bin/bash

# Exit immediately if any command fails
set -e

# Configure the software with specific options
./configure --prefix=/usr \  # Install to /usr
            --disable-static  # Disable building static libraries

# Build the software
make

# Install the software
make install
