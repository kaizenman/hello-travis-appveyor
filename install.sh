#!/bin/bash

if [ ! -d "build" ]; then
   mkdir build
fi
cd build
cmake ..
make
cd ..
if [ ! -d "bin" ]; then
   mkdir bin
fi
cp -vf build/bin/run_darwin bin/run_darwin
rm -r build