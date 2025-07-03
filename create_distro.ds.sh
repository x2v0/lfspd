#!/bin/bash

# Creates file lfspd.10.tar.gz with distribution 
image in $LFS/Distro directory

# When building from scratch is finished, run 
/sources/create_distros.sh

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Run the strip-all.sh script to clean up 
unnecessary files
/sources/strip-all.sh

# Define the output file name
file="lfspd.10.tar.gz"

# Copy necessary files to /root
cp /sources/.bash* /sources/setenv.sh /root/

# Create the Distro directory if it doesn't exist
mkdir -p /Distro

# Change to the Distro directory
cd /Distro || { echo "Failed to change to /Distro 
directory."; exit 1; }

# Create the tarball of the specified directories
tar -czf "${file}" \
  --exclude='./proc' \
  --exclude='./sys' \
  --exclude='./dev' \
  --exclude='./run' \
  --exclude='./tmp' \
  --exclude='./Distro' \
  --exclude='./lost+found' \
  bin boot etc home lib lib64 media opt root sbin 
sources srv tmp usr var

# Check if the tarball was created successfully
if [ $? -eq 0 ]; then
  echo "Distribution image created successfully: 
/Distro/${file}"
else
  echo "Failed to create the distribution image."
  exit 1
fi
