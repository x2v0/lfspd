#!/bin/bash

# Create log files and set permissions
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

# Export build flags
export MAKEFLAGS="-j$(nproc)"  # Enable parallel 
builds
export CFLAGS="-Wno-error -Os" # Set compiler 
flags

# Set LFS variable (if needed)
export LFS=""  # Ensure LFS is defined, even if 
empty

# Change to the sources directory
cd /sources || { echo "Failed to cd into 
/sources"; exit 1; }

# List of packages to install
packages=(
    zlib
    bzip2
    bison
    perl
    util-linux
    libffi
    readline
    gdbm
    openssl
    python
    texinfo
    gettext
)

# Loop through each package and install it
for p in "${packages[@]}"; do
    if ! source packageinstall.sh 7 "$p"; then
        echo "Failed to install package: $p"
        exit 1
    fi
done

echo "All packages installed successfully!"
