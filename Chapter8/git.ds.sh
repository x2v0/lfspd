#!/bin/bash

# Exit immediately if any command fails
set -e

# Configure the software with specific options
./configure --prefix=/usr                   \  # Install to /usr
            --with-gitconfig=/etc/gitconfig \  # Set the system-wide Git config file location
            --with-python=python3              # Use Python 3 for Git's Python-related features

# Build the software
make

# Install the software
make install
