echo "Running updater..."

if [ ! -d ./.latest ]; then
   mkdir ./.latest
fi
cd ./.latest
if [ ! -d bin ]; then
   mkdir bin
fi
cd bin

filename='unknown'

if [ "$(uname)" == "Darwin" ]; then
    filename='run_darwin'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    filename='run_linux'
fi


curl -s https://api.github.com/repos/makolyan/hello-world/releases/latest \
| grep "$filename*" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

chmod +x "$filename"