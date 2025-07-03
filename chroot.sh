#!/bin/bash

#set -x

export LFS="$1"

if [ "$LFS" == "" ]
then
  echo "Need to specify chroot dir as input parameter"
  exit 1
fi

echo $LFS

chroot "${LFS}" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/sbin:/usr/local/bin:/usr/bin:/usr/sbin     \
    /bin/bash --login
