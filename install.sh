#!/bin/bash

if [ ! -d "build" ]; then
   #create build directory if it not exist
   mkdir build
fi

cd build
echo "Preparing build... "
cmake ..
echo "Making binaries..."	
make

echo "Launching Updater"
cd ..

if [ ! -d "bin" ]; then
mkdir bin
fi
echo "copying run_linux..."
cp -uvf build/bin/run_linux bin/

echo "deleting build directory..."
rm -r build

source updater.sh
echo "Done"