#!/bin/bash

#set -x 

# save lfspd dir location == this script location
cd "$(dirname "$0")"
lfspd="$(pwd)"

# chroot dir default location is ~/tmp/lfspd
export chroot="$HOME/tmp/lfspd"

# one can specify it's own location
if [ $# -eq 1 ]
then
  chroot=$1
fi

if [ ! -d "${chroot}" ]; then
  echo "$chroot doesn't exist - create it!"
  mkdir -p "$chroot"
fi

if [ ! -f "./Distros/lfspd.10.tar" ]; then
  ./dock2tar.sh
fi

tar -xf Distros/lfspd.10.tar -C ${chroot}

sudo ${lfspd}/preparechroot.sh ${chroot}
sudo ${lfspd}/chroot.sh ${chroot}




