if [! -d "build"]; then
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

if [! -d "bin"]; then
mkdir bin
fi
echo "updating executable..."
cp -vf build/bin/run_linux bin/
source updater.sh
echo "Done"