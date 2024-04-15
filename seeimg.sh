#!/bin/bash



function seeimg(){
  if [ $1 ]; then
    kitty +kitten icat "$1"
  else
    echo -e "Ingrese una imagen"
  fi
} 

