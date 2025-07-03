#!/bin/bash

make install
install -vdm755 /etc/ssl/local

/usr/sbin/make-ca -g

wget http://www.cacert.org/certs/root.crt &&
wget http://www.cacert.org/certs/class3.crt &&
openssl x509 -in root.crt -text -fingerprint -setalias "CAcert Class 1 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_1_root.pem &&
openssl x509 -in class3.crt -text -fingerprint -setalias "CAcert Class 3 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_3_root.pem &&
/usr/sbin/make-ca -r

openssl x509 -in /etc/ssl/certs/Makebelieve_CA_Root.pem \
             -text \
             -fingerprint \
             -setalias "Disabled Makebelieve CA Root" \
             -addreject serverAuth \
             -addreject emailProtection \
             -addreject codeSigning \
       > /etc/ssl/local/Disabled_Makebelieve_CA_Root.pem &&
/usr/sbin/make-ca -r

mkdir -pv /etc/profile.d &&
cat > /etc/profile.d/pythoncerts.sh << "EOF"
# Begin /etc/profile.d/pythoncerts.sh

export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt

# End /etc/profile.d/pythoncerts.sh
EOF
