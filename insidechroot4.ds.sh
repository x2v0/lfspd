#!/bin/bash

# Enable debugging (optional, uncomment if 
needed)
# set -x

# Set compiler flags
export CFLAGS="-Wno-error -Os"

# Configure dynamic linker run-time bindings
echo "/usr/local/lib" > /etc/ld.so.conf || { echo 
"Failed to write to /etc/ld.so.conf"; exit 1; }
ldconfig -f /etc/ld.so.conf || { echo "Failed to 
run ldconfig"; exit 1; }
export LD_LIBRARY_PATH="/usr/lib:/usr/local/lib"

# Set LFS variable (if needed)
export LFS=""

# Change to the sources directory
cd /sources || { echo "Failed to cd into 
/sources"; exit 1; }

# Function to run a script and log its output
doit() {
  local script_name=$1
  local log_dir="/var/log/Chapter9"
  
  # Ensure the log directory exists
  mkdir -p "$log_dir" || { echo "Failed to create 
log directory: $log_dir"; exit 1; }
  
  # Run the script and log its output
  if ! source "Chapter9/${script_name}.sh" 2>&1 | 
tee "${log_dir}/${script_name}.log"; then
    echo "Failed to run script: 
${script_name}.sh"
    exit 1
  fi
}

# Install rsync
doit "rsync"

# List of packages to install
packages=(
    micro
    libxslt
    pcre2
    pcre
    lzo
    gdb
    sudo
    gsl
    libedit
    nasm
    yaml
    libxml2
    brotli
    libunwind
    sqlite
    rngstreams
    clhep
    fftw
    unuran
    libpng
    openssh
    popt
    cpio
    fuse
    unzip
    glib
    slang
    boost
    xerces-c
    mc
    libmd
    dpkg
    libsigsegv
)

# Loop through each package and install it
for p in "${packages[@]}"; do
  if ! source packageinstall.sh 9 "$p"; then
    echo "Failed to install package: $p"
    exit 1
  fi
done

# Install Berkeley DB
wget --no-check-certificate 
https://anduin.linuxfromscratch.org/BLFS/bdb/db-5.
3.28.tar.gz || { echo "Failed to download 
Berkeley DB"; exit 1; }
tar -xzf db-5.3.28.tar.gz || { echo "Failed to 
extract Berkeley DB"; exit 1; }
pushd db-5.3.28 || { echo "Failed to enter 
db-5.3.28 directory"; exit 1; }
doit "berkeley_db"
popd || { echo "Failed to return from db-5.3.28 
directory"; exit 1; }

# Install xxHash
wget --no-check-certificate 
https://github.com/Cyan4973/xxHash/archive/refs/ta
gs/v0.8.2.tar.gz || { echo "Failed to download 
xxHash"; exit 1; }
tar -xzf v0.8.2.tar.gz || { echo "Failed to 
extract xxHash"; exit 1; }
pushd xxHash-0.8.2 || { echo "Failed to enter 
xxHash-0.8.2 directory"; exit 1; }
make 2>&1 | tee /var/log/Chapter9/xxhash.log || { 
echo "Failed to build xxHash"; exit 1; }
make install || { echo "Failed to install 
xxHash"; exit 1; }
popd || { echo "Failed to return from 
xxHash-0.8.2 directory"; exit 1; }

# Install additional packages using the doit 
function
additional_packages=(
    lz4
    tbb
    hdf5
    eigen
    googletest
    abseil
    OpenBLAS
    range-v3
    re2
    re2c
    vdt
    catch2
    cppgsl
    nlohmann-json
)

for p in "${additional_packages[@]}"; do
  doit "$p"
done

echo "All packages installed successfully!"
