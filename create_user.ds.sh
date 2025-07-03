#!/bin/bash

# Disable /etc/bash.bashrc if it exists
if [ -e /etc/bash.bashrc ]; then
  sudo mv -v /etc/bash.bashrc 
/etc/bash.bashrc.NOUSE
fi

# Check if the 'lfs' user exists
exist=$(getent passwd | cut -f1 -d: | grep -w 
"lfs")

if [ -z "$exist" ]; then
  # Create the 'lfs' group and user
  groupadd lfs
  useradd -s /bin/bash -g lfs -m -k 
/dev/null lfs
  echo -e "lfs\nlfs" | passwd lfs

  # Allow 'lfs' user to run sudo without a 
password
  echo "lfs ALL=(ALL) NOPASSWD:ALL" | sudo tee -a 
/etc/sudoers > /dev/null
fi

# Copy necessary files to the 'lfs' home 
directory
cp -rf *.sh .bash* md5sums wget-list 
Chapter* /home/lfs/

# Switch to the 'lfs' user
su - lfs