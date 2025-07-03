#!/bin/bash

# Exit on error
set -e

# Upgrade pip
pip install --upgrade pip

# Install Python packages
pip install awkward
pip install cython
pip install markupsafe
pip install pyyaml
pip install setuptools
pip install six
pip install pytest
pip install tabulate
# Uncomment the following line if you need Jupyter
# pip install jupyter
pip install metakernel
pip install virtualenv
pip install readline

echo "Python packages installed successfully."
