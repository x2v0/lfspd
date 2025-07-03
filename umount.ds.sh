#!/bin/bash

# Check if the LFS directory is provided as an argument
if [ -z "$1" ]; then
  echo "Error: Need to specify the chroot directory as an input parameter."
  echo "Usage: $0 /path/to/chroot"
  exit 1
fi

export LFS="$1"

# Check if the LFS directory exists
if [ ! -d "$LFS" ]; then
  echo "Error: $LFS is not a valid directory."
  exit 1
fi

# Unmount filesystems in reverse order of mounting
umount -v "$LFS/dev/pts" 2>/dev/null || echo "Warning: Failed to unmount $LFS/dev/pts (may not be mounted)."

if mountpoint -q "$LFS/dev/shm"; then
  umount -v "$LFS/dev/shm" || echo "Warning: Failed to unmount $LFS/dev/shm."
fi

umount -v "$LFS/dev" 2>/dev/null || echo "Warning: Failed to unmount $LFS/dev (may not be mounted)."
umount -v "$LFS/run" 2>/dev/null || echo "Warning: Failed to unmount $LFS/run (may not be mounted)."
umount -v "$LFS/proc" 2>/dev/null || echo "Warning: Failed to unmount $LFS/proc (may not be mounted)."
umount -v "$LFS/sys" 2>/dev/null || echo "Warning: Failed to unmount $LFS/sys (may not be mounted)."
umount -v "$LFS/home" 2>/dev/null || echo "Warning: Failed to unmount $LFS/home (may not be mounted)."
umount -v "$LFS" 2>/dev/null || echo "Warning: Failed to unmount $LFS (may not be mounted)."

# Check if any filesystems are still mounted under LFS
if mount | grep "$LFS" > /dev/null; then
  echo "Warning: Some filesystems under $LFS are still mounted."
else
  echo "All filesystems under $LFS have been unmounted successfully."
fi
