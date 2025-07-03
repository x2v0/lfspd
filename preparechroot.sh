#!/bin/bash

export LFS="$1"

if [ "$LFS" == "" ]
then
  echo "Need to specify chroot dir as input parameter"
  exit 1
fi

mkdir -pv $LFS/{etc,var,boot,bin,lib,sbin,tools,usr}
chown -R root:root $LFS/{etc,var,boot,bin,lib,sbin,tools,usr}

case $(uname -m) in
 x86_64) chown -R root:root $LFS/lib64 ;;
esac


mkdir -pv $LFS/{dev,proc,sys,run}

mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

mount -v --bind /dev $LFS/dev

mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run


if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm)
else
    mount -t tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
