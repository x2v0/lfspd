#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr           \  # Install to /usr
            --with-tcl=/usr/lib     \  # Specify the Tcl library directory
            --enable-shared         \  # Enable building shared libraries
            --mandir=/usr/share/man \  # Set the directory for manual pages
            --with-tclinclude=/usr/include  # Specify the Tcl include directory

# Build the software
make

# Install the software
make install

# Create a symbolic link for the shared library
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
