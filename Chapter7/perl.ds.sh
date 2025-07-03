#!/bin/bash

# Exit on error
set -e

# Uncomment and set environment variables if needed
# export BUILD_ZLIB=False
# export BUILD_BZIP2=0

# Configure Perl build
echo "Configuring Perl build..."
sh Configure -des \
  -Dprefix=/usr \
  -Dvendorprefix=/usr \
  -Duseshrplib \
  -Dprivlib=/usr/lib/perl5/5.38/core_perl \
  -Darchlib=/usr/lib/perl5/5.38/core_perl \
  -Dsitelib=/usr/lib/perl5/5.38/site_perl \
  -Dsitearch=/usr/lib/perl5/5.38/site_perl \
  -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl \
  -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl <<< "y"

# Build Perl
echo "Building Perl..."
make

# Install Perl
echo "Installing Perl..."
make install

echo "Perl installation complete!"
