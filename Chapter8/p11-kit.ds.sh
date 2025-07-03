#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Modify the p11-kit source code
sed 's/if (gi/& \&\& gi != C_GetInterface/' \
    -i p11-kit/modules.c

# Truncate and append to the trust-extract-compat script
sed '20,$ d' -i trust/trust-extract-compat
cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF

# Create and enter the build directory
mkdir -p p11-build
cd p11-build

# Configure the build using Meson
meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Dtrust_paths=/etc/pki/anchors

# Build and install using Ninja
ninja
ninja install

# Create symbolic links
ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
        /usr/bin/update-ca-certificates

ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so
