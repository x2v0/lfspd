#!/bin/bash

export LFS="$1"

if [ "$LFS" == "" ]
then
  echo "Need to specify chroot dir as input parameter"
  exit 1
fi

umount -v $LFS/dev/pts
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys
umount -v $LFS/home
umount -v $LFS

