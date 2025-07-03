#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in git make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning rsync repository..."
if ! git clone https://github.com/WayneD/rsync; then
    echo "Error: Failed to clone rsync repository."
    exit 1
fi

# Add the rsyncd group and user
echo "Adding rsyncd group and user..."
if ! getent group rsyncd > /dev/null; then
    groupadd -g 48 rsyncd
fi
if ! getent passwd rsyncd > /dev/null; then
    useradd -c "rsyncd Daemon" -m -d /home/rsync -g rsyncd \
            -s /bin/false -u 48 rsyncd
fi

# Enter the cloned directory
pushd rsync || { echo "Error: Failed to enter directory rsync."; exit 1; }

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr    \
            --disable-lz4    \
            --disable-xxhash \
            --disable-md2man \
            --without-included-zlib

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of rsync completed successfully."
