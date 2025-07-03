#!/bin/bash

set -e  # Exit immediately if any command fails

# FFTW is a C subroutine library for computing the discrete Fourier transform (DFT)
# in one or more dimensions, of arbitrary input size, and of both real and complex data.

# Function to configure, build, and install FFTW
build_fftw() {
    local options=("$@")
    echo "Configuring FFTW with options: ${options[*]}"
    ./configure --prefix=/usr/local "${options[@]}" || { echo "Configuration failed"; exit 1; }

    echo "Building FFTW..."
    make || { echo "Build failed"; exit 1; }

    echo "Installing FFTW..."
    sudo make install || { echo "Installation failed"; exit 1; }

    echo "Cleaning up build..."
    make clean || { echo "Clean failed"; exit 1; }
}

# Build FFTW with double precision (default)
echo "Building FFTW with double precision..."
build_fftw --enable-shared --disable-static --enable-threads --enable-sse2 --enable-avx --enable-avx2

# Build FFTW with single precision (float)
echo "Building FFTW with single precision..."
build_fftw --enable-shared --disable-static --enable-threads --enable-sse2 --enable-avx --enable-avx2 --enable-float

# Build FFTW with long double precision
echo "Building FFTW with long double precision..."
build_fftw --enable-shared --disable-static --enable-threads --enable-long-double

echo "FFTW installation completed successfully!"
