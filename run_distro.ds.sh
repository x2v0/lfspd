#!/bin/bash

# Enable debugging if needed
# set -x

# Save the directory where this script is located
script_dir="$(cd "$(dirname "$0")" && pwd)"

# Default chroot directory location
chroot="$HOME/tmp/lfspd"

# Allow user to specify a custom chroot directory
if [ $# -eq 1 ]; then
  chroot="$1"
fi

# Create the chroot directory if it doesn't exist
if [ ! -d "${chroot}" ]; then
  echo "Directory $chroot does not exist. Creating it..."
  mkdir -p "$chroot" || { echo "Failed to create $chroot"; exit 1; }
fi

# Check if the lfspd.10.tar file exists; if not, generate it
if [ ! -f "./Distros/lfspd.10.tar" ]; then
  echo "lfspd.10.tar not found. Generating it..."
  ./dock2tar.sh || { echo "Failed to generate lfspd.10.tar"; exit 1; }
fi

# Extract the tarball into the chroot directory
echo "Extracting lfspd.10.tar into $chroot..."
tar -xf "./Distros/lfspd.10.tar" -C "${chroot}" || { echo "Failed to extract tarball"; exit 1; }

# Prepare and enter the chroot environment
echo "Preparing chroot environment..."
sudo "${script_dir}/preparechroot.sh" "${chroot}" || { echo "Failed to prepare chroot"; exit 1; }

echo "Entering chroot environment..."
sudo "${script_dir}/chroot.sh" "${chroot}" || { echo "Failed to enter chroot"; exit 1; }

echo "Chroot setup and execution completed successfully."
