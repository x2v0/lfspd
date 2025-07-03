#!/bin/bash

# Creates lfspd Docker image from 
$LFS/Distro/lfspd.10.tar.gz

# Check if Docker is installed
docker=$(command -v docker)
if [ -z "$docker" ]; then
  echo "Error: Docker is not installed or not in 
the PATH."
  exit 1
fi

# Define the path to the tarball
file="$LFS/Distro/lfspd.10.tar.gz"

# Check if the tarball exists
if [ ! -f "$file" ]; then
  echo "Error: The file $file does not exist."
  exit 1
fi

# Import the tarball into Docker as an image
echo "Importing $file into Docker as image 
'lfspd'..."
if "$docker" import "$file" lfspd; then
  echo "Docker image 'lfspd' created 
successfully."
else
  echo "Error: Failed to create Docker image."
  exit 1
fi
