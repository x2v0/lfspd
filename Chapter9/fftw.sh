#!/bin/bash

# FFTW is a C subroutine library for computing the discrete                                                                                             2 # Fourier transform (DFT) in one or more dimensions, of arbitrary input size,
# and of both real and complex data (as well as of even/odd data,
# i.e. the discrete cosine/sine transforms or DCT/DST).

./configure --prefix=/usr/local \
            --enable-shared     \
            --disable-static    \
            --enable-threads    \
            --enable-sse2       \
            --enable-avx        \
            --enable-avx2 
make
make install

make clean

./configure --prefix=/usr/local \
            --enable-shared     \
            --disable-static    \
            --enable-threads    \
            --enable-sse2       \
            --enable-avx        \
            --enable-avx2       \
            --enable-float
make
make install

make clean

./configure --prefix=/usr/local   \
            --enable-shared       \
            --disable-static      \
            --enable-threads      \
            --enable-long-double
make
make install

