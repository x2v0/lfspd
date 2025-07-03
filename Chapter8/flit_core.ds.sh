#!/bin/bash

# Exit immediately if any command fails
set -e

# Build the Python package into a wheel and save it in the `dist` directory
# --no-build-isolation: Disables isolation to use the current environment for building
# --no-deps: Does not install dependencies
# $PWD: Specifies the current directory as the source
pip3 wheel -w dist --no-build-isolation --no-deps $PWD

# Install the wheel from the `dist` directory
# --no-index: Does not use the Python Package Index (PyPI)
# --no-user: Installs system-wide (not user-specific)
# --find-links dist: Looks for wheels in the `dist` directory
pip3 install --no-index --no-user --find-links dist flit_core
