#!/bin/bash

# The OpenSSH package contains ssh clients and the sshd daemon.
# This is useful for encrypting authentication and subsequent traffic over a network.
# The ssh and scp commands are secure implementations of telnet and rcp respectively.

PKG="openssh"
PKG_VERSION="9.4p1"
PKG_BUILD="0"
PKG_FULL=${PKG}-${PKG_VERSION}
PKG_FILE="${PKG_FULL}.tar.gz"

URL="https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/${PKG_FILE}"
MD5="4bbd56a7ba51b0cd61debe8f9e77f8bb"

./configure --prefix=/usr                             \
            --sysconfdir=/etc/ssh                     \
            --with-privsep-path=/var/lib/sshd         \
            --with-default-path=/usr/bin              \
            --with-superuser-path=/usr/sbin:/usr/bin  \
            --with-pid-dir=/run
make
make install
install -v -m755  contrib/ssh-copy-id /usr/bin

install -v -m644    contrib/ssh-copy-id.1             \
                    /usr/share/man/man1
                    
install -v -m755 -d /usr/share/doc/openssh-9.4p1
install -v -m644    INSTALL LICENCE OVERVIEW README*  \
                    /usr/share/doc/openssh-9.4p1
                    
install -v -g sys -m700 -d /var/lib/sshd &&

groupadd -g 50 sshd        &&
useradd  -c 'sshd PrivSep' \
         -d /var/lib/sshd  \
         -g sshd           \
         -s /bin/false     \
         -u 50 sshd
