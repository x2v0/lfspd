#!/bin/bash

# The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.                                                                    2 # It provides a wide range of mathematical routines such as
# random number generators, special functions and least-squares fitting.

PKG="gsl"
PKG_VERSION="2.7"
PKG_BUILD="1"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://ftp.gnu.org/${PKG}/${PKG_FILE}"
#MD5="36aee97e67f64dbdab7afae197e3483b"

./configure --prefix=/usr/local --disable-static
make
make install

# !! fuck gcc doesn't have __has_warning macro
sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/span
sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/util
