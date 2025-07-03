#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Remove ARPD (ARP daemon) related entries from the Makefile
sed -i /ARPD/d Makefile

# Remove the ARPD man page
rm -fv man/man8/arpd.8

# Build the software with a custom NETNS_RUN_DIR
make NETNS_RUN_DIR=/run/netns

# Install the software with SBINDIR set to /usr/sbin
make SBINDIR=/usr/sbin install
