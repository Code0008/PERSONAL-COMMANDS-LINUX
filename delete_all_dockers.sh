#!/bin/bash
# este comando se encarga de eliminar todas las imagenes y volumenes de docker que tengasinstalado 


echo  "[!!!] SE ELMINARAN TODAS LAS IMAGENES, ESTA SEGURO? (Y)si/(N)no: "

read condicion 
if [ $condicion = "y" ]; then
    docker rm $(docker ps -a -q) --force 
    echo  "[!]Elimnamos todos los contenedores "
    docker rmi $(docker images -q)
    echo  "[!!!] elmiminamos todas las imagenes"
 else 
  echo  "[+] No se ejecuto operacion o opcion incorrecta"
 fi
