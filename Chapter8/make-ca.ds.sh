#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Install the software
make install

# Create the directory for local SSL certificates
install -vdm755 /etc/ssl/local

# Generate the certificate authority (CA) certificates
/usr/sbin/make-ca -g

# Download and process CAcert root certificates
wget http://www.cacert.org/certs/root.crt
wget http://www.cacert.org/certs/class3.crt

openssl x509 -in root.crt -text -fingerprint -setalias "CAcert Class 1 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_1_root.pem

openssl x509 -in class3.crt -text -fingerprint -setalias "CAcert Class 3 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_3_root.pem

# Update the CA certificate store
/usr/sbin/make-ca -r

# Process and disable the Makebelieve CA Root certificate
openssl x509 -in /etc/ssl/certs/Makebelieve_CA_Root.pem \
             -text \
             -fingerprint \
             -setalias "Disabled Makebelieve CA Root" \
             -addreject serverAuth \
             -addreject emailProtection \
             -addreject codeSigning \
       > /etc/ssl/local/Disabled_Makebelieve_CA_Root.pem

# Update the CA certificate store again
/usr/sbin/make-ca -r

# Create the directory for profile scripts
mkdir -pv /etc/profile.d

# Create a profile script for Python certificates
cat > /etc/profile.d/pythoncerts.sh << "EOF"
# Begin /etc/profile.d/pythoncerts.sh

export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt

# End /etc/profile.d/pythoncerts.sh
EOF
