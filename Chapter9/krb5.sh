
PKG="krb5"
PKG_VERSION="1.21"
PKG_BUILD="2"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL=" https://kerberos.org/dist/${PKG}/${PKG_VERSION}/${PKG_FILE}"
 
pushd src
./configure --prefix=/usr/local --disable-static

make
make install

popd

