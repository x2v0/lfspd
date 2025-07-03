#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Build the package using Python's setup.py
python3 setup.py build

# Install the package using Python's setup.py
python3 setup.py install

# Optional: Install shell completions (commented out by default)
# install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
# install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
