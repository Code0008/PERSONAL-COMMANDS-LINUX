#!/bin/bash

function backup(){
if [ $1 ]; then
  7z a "/home/moltengama/.backups/$1.$2" &>/dev/null
else
  echo -e "No recibimos ningun parametro ingrese ga "
fi
}

