#!/bin/bash

# Exit immediately if any command fails
set -e

# Configure the software with specific options
./configure --prefix=/usr    \  # Install to /usr
            --disable-static \  # Disable building static libraries
            --docdir=/usr/share/doc/gettext-0.22  # Set the documentation directory

# Build the software
make

# Install the software
make install

# Set the correct permissions for the shared library
chmod -v 0755 /usr/lib/preloadable_libintl.so
