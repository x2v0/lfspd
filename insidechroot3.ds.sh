#!/bin/bash

# Enable debugging (optional, uncomment if 
needed)
# set -x

# Create log files and set permissions
touch /var/log/{btmp,lastlog,faillog,wtmp} || { 
echo "Failed to create log files"; exit 1; }
chgrp -v utmp /var/log/lastlog || { echo "Failed 
to change group for /var/log/lastlog"; exit 1; }
chmod -v 664 /var/log/lastlog || { echo "Failed 
to set permissions for /var/log/lastlog"; exit 1; 
}
chmod -v 600 /var/log/btmp || { echo "Failed to 
set permissions for /var/log/btmp"; exit 1; }

# Export build flags
# export MAKEFLAGS="-j$(nproc)"  # Enable 
parallel builds (uncomment if needed)
export CFLAGS="-Wno-error -Os"  # Set compiler 
flags
export LFS=""  # Ensure LFS is defined, even if 
empty

# Change to the sources directory
cd /sources || { echo "Failed to cd into 
/sources"; exit 1; }

# List of packages to install
packages=(
    iana-etc
    zlib
    bzip2
    xz
    zstd
    readline
    gettext
    bc
    flex
    tcl
    expect
    dejagnu
    gmp
    mpfr
    mpc
    attr
    acl
    libcap
    libxcrypt
    pkgconf
    psmisc
    libtool
    gdbm
    gperf
    expat
    inetutils
    less
    XML-Parser
    intltool
    autoconf
    automake
    libelf
    libffi
    flit_core
    wheel
    ninja
    meson
    check
    iproute2
    kbd
    libpipeline
    MarkupSafe
    Jinja2
    procps-ng
    libunistring
    libidn2
    libpsl
    libarchive
    libuv
    libiconv
    wget
    curl
    git
    cmake
    libtasn1
    vim
    shadow
    p11-kit
    make-ca
)

# Loop through each package and install it
for p in "${packages[@]}"; do
    if ! source packageinstall.sh 8 "$p"; then
        echo "Failed to install package: $p"
        exit 1
    fi
done

# Create /usr/bin/which script
cat > /usr/bin/which << "EOF"
#!/bin/bash
type -pa "$@" | head -n 1 ; exit ${PIPESTATUS[0]}
EOF

# Set permissions and ownership for 
/usr/bin/which
chmod -v 755 /usr/bin/which || { echo "Failed to 
set permissions for /usr/bin/which"; exit 1; }
chown -v root:root /usr/bin/which || { echo 
"Failed to set ownership for /usr/bin/which"; 
exit 1; }

echo "All packages installed and /usr/bin/which 
configured successfully!"
