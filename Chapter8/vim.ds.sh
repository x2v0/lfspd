#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Add a system-wide vimrc configuration to feature.h
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

# Configure the build
./configure --prefix=/usr

# Build and install
make
make install

# Create a symbolic link for vi
ln -sv /usr/bin/vim /usr/bin/vi
