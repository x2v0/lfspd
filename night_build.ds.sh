#!/bin/bash

# This script rebuilds the LFS distribution from 
scratch on a dedicated "machine" (Debian).
# It is executed every day at 00:00.

# Enable debugging (optional, uncomment if 
needed)
# set -x

# Record the start time
start=$(date)
echo "Build started at: ${start}"

# Clear the terminal
clear

# Clean up $LFS
echo "Cleaning up $LFS..."
if ! ./umount.sh "$LFS"; then
  echo "Failed to unmount $LFS. Exiting."
  exit 1
fi

if ! rm -rf "$LFS"/*; then
  echo "Failed to clean $LFS. Exiting."
  exit 1
fi

# Pull the latest changes from the repository
echo "Pulling the latest changes from the 
repository..."
if ! git pull -p; then
  echo "Failed to pull the latest changes. 
Exiting."
  exit 1
fi

# Rebuild everything
echo "Starting the build process..."
if ! ./start.sh; then
  echo "Build failed. Exiting."
  exit 1
fi

# Record the stop time
stop=$(date)
echo "Build finished at: ${stop}"

# Print build duration
echo "Nightly building finished!"
echo "Start time: ${start}"
echo "Stop time: ${stop}"
