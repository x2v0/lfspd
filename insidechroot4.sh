#!/bin/bash

export CFLAGS="-Wno-error -Os"
echo "/usr/local/lib" > /etc/ld.so.config
ldconfig -f /etc/ld.so.config
export LD_LIBRARY_PATH="/usr/lib:/usr/local/lib"

export LFS=""
cd /sources

doit() {
  source Chapter9/${1}.sh 2>&1 | tee /var/log/Chapter9/${1}.log
}

# rsync
doit "rsync"

for p in \
micro \
libxslt \
pcre2 \
pcre \
lzo \
gdb \
sudo \
gsl \
libedit \
nasm \
yaml \
libxml2 \
brotli \
libunwind \
sqlite \
rngstreams \
clhep \
fftw \
unuran \
libpng \
openssh \
popt \
cpio \
fuse \
unzip \
glib \
slang \
boost \
xerces-c \
mc \
libmd \
dpkg \
libsigsegv
do
source packageinstall.sh 9 ${p}
done

# berkley-db
wget --no-check-certificate https://anduin.linuxfromscratch.org/BLFS/bdb/db-5.3.28.tar.gz
tar -xzf db-5.3.28.tar.gz
pushd db-5.3.28
source ../Chapter9/berkeley_db.sh  2>&1 | tee /var/log/Chapter9/berkeley_db.log
popd


# xxHash
wget --no-check-certificate https://github.com/Cyan4973/xxHash/archive/refs/tags/v0.8.2.tar.gz
tar -xzf v0.8.2.tar.gz
pushd xxHash-0.8.2
make  2>&1 | tee /var/log/Chapter9/xxhash.log
make install
popd


# lz4
doit "lz4"

# tbb
doit "tbb"

# hdf5
doit "hdf5"

# eigen
doit "eigen"

# googletest
doit "googletest"

# abseil
doit "abseil"

# OpenBLAS
doit "OpenBLAS"

# range-v3
doit "range-v3"

# re2
doit "re2"

# re2c
doit "re2c"

# vdt
doit "vdt"

# catch2
doit "catch2"

# cppgsl
doit "cppgsl"

# nlohmann-json
doit "nlohmann-json"
