#!/bin/bash

# Configure the software with specific options
./configure --prefix=/usr                  \  # Install to /usr
            --disable-static               \  # Disable building static libraries
            --with-openssl                 \  # Enable support for OpenSSL
            --enable-threaded-resolver     \  # Enable threaded DNS resolver
            --with-ca-path=/etc/ssl/certs     # Set the path to CA certificates

# Build the software
make

# Install the software
make install
