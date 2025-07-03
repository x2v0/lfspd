#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Package details
PKG="openssh"
PKG_VERSION="9.4p1"
PKG_BUILD="0"
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/${PKG_FILE}"
MD5="4bbd56a7ba51b0cd61debe8f9e77f8bb"

# Check for necessary tools
for cmd in wget tar make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Download the package
echo "Downloading ${PKG_FILE}..."
if ! wget -q "$URL"; then
    echo "Error: Failed to download ${PKG_FILE}."
    exit 1
fi

# Verify the MD5 checksum
echo "Verifying MD5 checksum..."
if ! echo "${MD5}  ${PKG_FILE}" | md5sum -c -; then
    echo "Error: MD5 checksum verification failed for ${PKG_FILE}."
    exit 1
fi

# Extract the package
echo "Extracting ${PKG_FILE}..."
if ! tar -xzf "$PKG_FILE"; then
    echo "Error: Failed to extract ${PKG_FILE}."
    exit 1
fi

# Enter the extracted directory
cd "$PKG_FULL" || { echo "Error: Failed to enter directory ${PKG_FULL}."; exit 1; }

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr                             \
            --sysconfdir=/etc/ssh                     \
            --with-privsep-path=/var/lib/sshd         \
            --with-default-path=/usr/bin              \
            --with-superuser-path=/usr/sbin:/usr/bin  \
            --with-pid-dir=/run

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Install additional files
echo "Installing additional files..."
install -v -m755 contrib/ssh-copy-id /usr/bin
install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
install -v -m755 -d /usr/share/doc/openssh-9.4p1
install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-9.4p1

# Create the privilege separation directory
echo "Creating privilege separation directory..."
install -v -g sys -m700 -d /var/lib/sshd

# Add the sshd user and group
echo "Adding sshd user and group..."
if ! getent group sshd > /dev/null; then
    groupadd -g 50 sshd
fi
if ! getent passwd sshd > /dev/null; then
    useradd -c 'sshd PrivSep' \
            -d /var/lib/sshd  \
            -g sshd           \
            -s /bin/false     \
            -u 50 sshd
fi

echo "Installation of ${PKG_FULL} completed successfully."
