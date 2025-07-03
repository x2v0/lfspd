#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr               \
            --libexecdir=/usr/lib       \
            --with-secure-path          \
            --with-all-insults          \
            --with-env-editor           \
            --docdir=/usr/local/share/doc/sudo-1.9.14p3     \
            --with-passprompt="[sudo] password for %p: "

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Create symbolic link
echo "Creating symbolic link..."
ln -sfv libsudo_util.so.0.0.0 /usr/local/lib/sudo/libsudo_util.so.0

echo "Installation of sudo completed successfully."
