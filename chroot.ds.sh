#!/bin/bash

# Enable debugging if needed
# set -x

# Check if the LFS directory is provided as an 
argument
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/chroot"
  exit 1
fi

export LFS="$1"

# Validate that the LFS directory exists
if [ ! -d "$LFS" ]; then
  echo "Error: The specified chroot directory 
does not exist: $LFS"
  exit 1
fi

echo "Chrooting into: $LFS"

# Execute chroot with a clean environment
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    
PATH=/bin:/sbin:/usr/local/bin:/usr/bin:/usr/sbin 
\
    /bin/bash --login
    