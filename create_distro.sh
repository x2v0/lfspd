#!/bin/bash

# Creares file lfspd.10.tar.gz with distribution image in $LFS/Distro directory

# When building from scraatch is finished run /sources/create_distros.sh

/sources/strip-all.sh

file=lfspd.10.tar.gz

cp /sources/.bash* /sources/setenv.sh /root/

mkdir -p /Distro
cd /Distro
tar -czf ${file} {/bin,/boot,/etc,/home,/lib,/lib64,/media,/opt,/root,/run,/sbin,/sources,/srv,/tmp,/usr,/var}
