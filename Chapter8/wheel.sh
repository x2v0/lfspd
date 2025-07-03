#!/bin/bash

pip3 wheel -w dist --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links=dist wheel
