#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure --disable-shared

# Build the software
echo "Building the software..."
make

# Copy necessary binaries
echo "Copying binaries to /usr/bin..."
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

echo "Installation complete!"
