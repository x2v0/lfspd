#!/bin/bash

# Create ~/.bash_profile
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' 
/bin/bash
EOF

# Create ~/.bashrc
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/LFS
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin:/usr/sbin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

# Apply the new environment
source ~/.bash_profile
