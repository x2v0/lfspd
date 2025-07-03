#!/bin/bash

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

#export MAKEFLAGS="-j$(nproc)"
export CFLAGS="-Wno-error -Os"

export LFS=""
cd /sources

for p in zlib bzip2 bison perl util-linux libffi readline gdbm openssl python texinfo gettext
do
    source packageinstall.sh 7 ${p}
done

