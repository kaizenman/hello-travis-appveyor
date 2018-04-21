#!/bin/bash

#--------- CODE STARTS HERE -------------------------------------------------------


#--------- glfw ------------------------------
currentDir=`pwd`
if [[ "$TRAVIS_OS_NAME" == "osx" ]];
  then echo "Installing for osx"
  brew install glfw;
  cd "$currentDir"
elif [[ "$TRAVIS_OS_NAME" == "linux" ]];
  then echo "Installing for Linux"
  sudo apt-get install xorg-dev libglu1-mesa-dev

  git clone https://github.com/glfw/glfw \
    && cd glfw \
    && mkdir build \
    && cd build \
    && cmake ../glfw && make -j4 \
    && sudo make install

  cd "$currentDir"

  if [ ! -d "./.include" ]; then
   mkdir ./.include
  fi

  cp -Rv ./glfw/include ./.include 
  sudo rm -r glfw
fi

#--------- GET GLEW ----------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------

#---------GET GLUT --------------------------------------------------------------------------------------------

