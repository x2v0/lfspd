#!/bin/bash

# Exit immediately if any command fails
set -e

# Copy the `services` and `protocols` files to `/etc`
cp -v services protocols /etc
