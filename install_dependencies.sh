#!/bin/bash

#--------- CODE STARTS HERE -------------------------------------------------------
echo "Installing for Linux"

#--------- glfw ------------------------------
currentDir=`pwd`
if [[ "$TRAVIS_OS_NAME" == "osx" ]];
  then brew install glfw; 
elif [[ "$TRAVIS_OS_NAME" == "linux" ]];
  then git clone https://github.com/glfw/glfw \
    && mkdir build \
    && cd build \
    && cmake ../glfw && make -j4 \
    && sudo make install
fi
cd $currentDir

#--------- GET GLEW ----------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------

#---------GET GLUT --------------------------------------------------------------------------------------------

