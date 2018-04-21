#!/bin/bash

mkdir build
cd build
cmake ..
make
cd ..
cp -vf build/bin/run_darwin bin/run_darwin
rm -r build