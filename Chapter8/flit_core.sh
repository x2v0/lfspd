#!/bin/bash

pip3 wheel -w dist --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist flit_core
