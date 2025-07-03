#!/bin/bash

# The Sudo package allows a system administrator to give certain users (or groups of users)                          
# the ability to run some (or all) commands as root or another user while logging the commands and arguments
 

./configure --prefix=/usr               \
            --libexecdir=/usr/lib       \
            --with-secure-path          \
            --with-all-insults          \
            --with-env-editor           \
            --docdir=/usr/local/share/doc/sudo-1.9.14p3     \
            --with-passprompt="[sudo] password for %p: "
make
make install
ln -sfv libsudo_util.so.0.0.0 /usr/local/lib/sudo/libsudo_util.so.0

