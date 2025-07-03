#!/bin/bash

# This script sets env vars in the final chrooted system 
export LC_ALL=C;

# set ROOT enviroment
source /usr/local/bin/thisroot.sh

# export Geant4 DATA files
sed -i 's|# export|export|g' /usr/local/bin/geant4.sh
source /usr/local/bin/geant4.sh

export PYTHONPATH=/usr/local/python${PYTHONPATH:+:${PYTHONPATH}}
export ROOT_INCLUDE_PATH=/usr/include:/usr/local/include

export PYTHIA8=/usr/local
export PYTHIA8DATA=/usr/local/share/Pythia8/xmldoc

export FCCDETECTORS=/usr/local/share/FCCDetectors

