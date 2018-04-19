echo "Running updater..."
if [ ! -d "bin" ]; then
   mkdir bin
fi
cd bin
curl -s https://api.github.com/repos/makolyan/hello-world/releases/latest \
| grep "run_linux" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -N -
chmod +x run_linux