#!/bin/bash

#set -x

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

#export MAKEFLAGS="-j$(nproc)"
export CFLAGS="-Wno-error -Os"
export LFS=""

cd /sources

for p in \
iana-etc \
zlib \
bzip2 \
xz \
zstd \
readline \
gettext \
bc \
flex \
tcl \
expect \
dejagnu \
gmp \
mpfr \
mpc \
attr \
acl \
libcap \
libxcrypt \
pkgconf \
psmisc \
libtool \
gdbm \
gperf \
expat \
inetutils \
less \
XML-Parser \
intltool \
autoconf \
automake \
libelf \
libffi \
flit_core \
wheel \
ninja \
meson \
check \
iproute2 \
kbd \
libpipeline \
MarkupSafe \
Jinja2 \
procps-ng \
libunistring \
libidn2 \
libpsl \
libarchive \
libuv \
libiconv \
wget \
curl \
git \
cmake \
libtasn1 \
vim \
shadow \
p11-kit \
make-ca
do
source packageinstall.sh 8 ${p}
done

# which
cat > /usr/bin/which << "EOF"
#!/bin/bash
type -pa "$@" | head -n 1 ; exit ${PIPESTATUS[0]}
EOF
chmod -v 755 /usr/bin/which
chown -v root:root /usr/bin/which
