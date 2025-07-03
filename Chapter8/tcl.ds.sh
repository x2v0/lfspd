#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Enable parallel compilation (optional)
# export MAKEFLAGS="-j$(nproc)"

# Store the current directory
SRCDIR=$(pwd)

# Change to the unix directory
cd unix

# Configure the build
./configure --prefix=/usr           \
            --mandir=/usr/share/man

# Build the software
make

# Update paths in configuration files
sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.5|/usr/lib/tdbc1.1.5|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/library|/usr/lib/tcl8.6|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5|/usr/include|"            \
    -i pkgs/tdbc1.1.5/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.3|/usr/lib/itcl4.2.3|" \
    -e "s|$SRCDIR/pkgs/itcl4.2.3/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.2.3|/usr/include|"            \
    -i pkgs/itcl4.2.3/itclConfig.sh

# Unset SRCDIR to avoid potential issues
unset SRCDIR

# Install the software
make install

# Make the shared library writable
chmod -v u+w /usr/lib/libtcl8.6.so

# Install private headers
make install-private-headers

# Create a symbolic link for tclsh
ln -sfv tclsh8.6 /usr/bin/tclsh

# Rename a man page
mv -v /usr/share/man/man3/{Thread,Tcl_Thread}.3
