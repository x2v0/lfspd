#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr        \  # Install to /usr
            --bindir=/usr/bin    \  # Set the directory for binaries
            --localstatedir=/var \  # Set the directory for variable data
            --disable-logger     \  # Disable the logger utility
            --disable-whois      \  # Disable the whois utility
            --disable-rcp        \  # Disable the rcp utility
            --disable-rexec      \  # Disable the rexec utility
            --disable-rlogin     \  # Disable the rlogin utility
            --disable-rsh        \  # Disable the rsh utility
            --disable-servers       # Disable server components

# Build and install the software
# Use `&&` to ensure `make install` only runs if `make` succeeds
make && make install

# Move the `ifconfig` binary from /usr/bin to /usr/sbin
mv -v /usr/bin/ifconfig /usr/sbin/ifconfig
