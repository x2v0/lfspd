#!/bin/bash

set -e  # Exit immediately if any command fails

echo "===> Downloading packages..."
while read -r line; do
    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi

    # Extract the tarball name from the URL
    tarball=$(basename "$line")

    # Check if the package already exists
    if [[ -f "$tarball" ]]; then
        echo "===> Package $tarball already 
exists. Skipping download."
        continue
    fi

    # Download the package
    echo "===> Downloading $tarball..."
    if ! wget --no-check-certificate "$line"; 
then
        echo "===> Failed to download $tarball!"
        exit 1
    fi
done < wget-list

echo "===> Verifying MD5SUM..."
while read -r line; do
    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi

    # Extract MD5 checksum and filename
    MD5=$(echo "$line" | cut -d ' ' -f 1)
    FILE=$(echo "$line" | cut -d ' ' -f 2)

    # Verify the MD5 checksum
    if ! echo "$MD5 $FILE" | md5sum -c --quiet; 
then
        echo "===> Verification of $FILE failed! 
MD5 mismatch!"
        exit 1
    else
        echo "===> $FILE: OK"
    fi
done < md5sums

echo "===> All packages downloaded and verified 
successfully."
