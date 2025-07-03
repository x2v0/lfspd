#!/bin/bash

# Set environment variables for the final 
chrooted system

# Ensure consistent locale settings
export LC_ALL=C

# Set up ROOT environment
if [ -f /usr/local/bin/thisroot.sh ]; then
  source /usr/local/bin/thisroot.sh || { echo 
"Failed to source thisroot.sh"; exit 1; }
else
  echo "Error: /usr/local/bin/thisroot.sh not 
found. ROOT environment not set."
  exit 1
fi

# Export Geant4 DATA files
if [ -f /usr/local/bin/geant4.sh ]; then
  sed -i 's|# export|export|g' 
/usr/local/bin/geant4.sh || { echo "Failed to 
modify geant4.sh"; exit 1; }
  source /usr/local/bin/geant4.sh || { echo 
"Failed to source geant4.sh"; exit 1; }
else
  echo "Error: /usr/local/bin/geant4.sh not 
found. Geant4 environment not set."
  exit 1
fi

# Set Python-related environment variables
export 
PYTHONPATH="/usr/local/python${PYTHONPATH:+:${PYTH
ONPATH}}"
export 
ROOT_INCLUDE_PATH="/usr/include:/usr/local/include
"

# Set Pythia8 environment variables
export PYTHIA8="/usr/local"
export 
PYTHIA8DATA="/usr/local/share/Pythia8/xmldoc"

# Set FCCDetectors environment variable
export 
FCCDETECTORS="/usr/local/share/FCCDetectors"

echo "Environment variables set successfully."
