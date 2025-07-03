#!/bin/bash

# Check if the LFS directory is provided as an 
argument
if [ -z "$1" ]; then
  echo "Usage: $0 <chroot-directory>"
  exit 1
fi

export LFS="$1"

# Create necessary directories
mkdir -pv 
$LFS/{etc,var,boot,bin,lib,sbin,tools,usr}
chown -R root:root 
$LFS/{etc,var,boot,bin,lib,sbin,tools,usr}

# Handle 64-bit architecture
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Create additional directories
mkdir -pv $LFS/{dev,proc,sys,run}

# Create necessary device nodes
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

# Mount necessary filesystems
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

# Handle /dev/shm
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
else
  mount -t tmpfs -o nosuid,nodev tmpfs 
$LFS/dev/shm
fi

echo "Setup completed successfully."
