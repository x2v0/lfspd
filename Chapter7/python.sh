#!/usr/bash

./configure --prefix=/usr --enable-shared \
  --disable-test-modules \
  --with-pydebug \
  --with-system-ffi

make -k
make install

# !!! ??
cp -rf /usr/include/python3.11d/* /usr/include
 
ln -sv /bin/python3 /bin/python
ln -sv /bin/pip3 /bin/pip
