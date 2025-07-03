#!/bin/bash

# The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.
# It provides a wide range of mathematical routines such as
# random number generators, special functions, and least-squares fitting.

PKG="gsl"
PKG_VERSION="2.7"
PKG_BUILD="1"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://ftp.gnu.org/gnu/${PKG}/${PKG_FILE}"  # Corrected URL
MD5="36aee97e67f64dbdab7afae197e3483b"  # Add the MD5 checksum if available for verification

# Download the package
if ! wget "$URL"; then
    echo "Failed to download $PKG_FILE. Please check the URL and try again."
    exit 1
fi

# Verify the MD5 checksum (optional but recommended if MD5 is provided)
if [[ -n "$MD5" ]]; then
    if ! echo "$MD5  $PKG_FILE" | md5sum -c -; then
        echo "MD5 checksum verification failed. The downloaded file may be corrupted."
        exit 1
    fi
fi

# Extract the package
if ! tar -xzf "$PKG_FILE"; then
    echo "Failed to extract $PKG_FILE. Please check the file and try again."
    exit 1
fi

# Navigate into the extracted directory
cd "$PKG_FULL" || {
    echo "Failed to enter directory $PKG_FULL. Please check the extraction."
    exit 1
}

# Configure the build
if ! ./configure --prefix=/usr/local --disable-static; then
    echo "Configuration failed. Please check the dependencies and try again."
    exit 1
fi

# Build the project
if ! make -j$(nproc); then
    echo "Build failed. Please check the errors and try again."
    exit 1
fi

# Install the built files (with sudo for necessary permissions)
if ! sudo make install; then
    echo "Installation failed. Please check the permissions and try again."
    exit 1
fi

# Fix for GCC not having the __has_warning macro
for file in /usr/local/include/gsl/span /usr/local/include/gsl/util; do
    if [[ -f "$file" ]]; then
        sudo sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' "$file"
    else
        echo "Warning: File $file not found. Skipping modification."
    fi
done

# Navigate back to the original directory
cd .. || {
    echo "Failed to return to the original directory."
    exit 1
}

# Clean up by removing the extracted directory
rm -rf "$PKG_FULL"

echo "GSL installation completed successfully."
