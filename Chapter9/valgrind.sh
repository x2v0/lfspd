
sed -i 's|/doc/valgrind||' docs/Makefile.in &&

./configure --prefix=/usr/local \
            --datadir=/usr/local/share/doc/${PKG_FULL}
make
make install

