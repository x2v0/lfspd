#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Build wheels for the current project
pip3 wheel -w dist --no-build-isolation --no-deps $PWD

# Install the wheel from the dist directory
pip3 install --no-index --find-links=dist wheel
