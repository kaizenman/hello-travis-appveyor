#!/bin/bash

filename='unknown'

if [ "$(uname)" == "Darwin" ]; then
    filename='run_darwin'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    filename='run_linux'
fi

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
cp -vf build/bin/"$filename" bin/"$filename"
rm -r build