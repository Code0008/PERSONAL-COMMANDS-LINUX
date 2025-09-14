#!/bin/bash

# Verificar que se haya pasado un argumento
if [ -z "$1" ]; then
    echo "Uso: $0 nombremaquina_ip"
    exit 1
fi

# Definir la ruta base
BASE_DIR="/home/kali/soluciones/maquinas"

# Nombre del nuevo directorio
NUEVO_DIR="${BASE_DIR}/$1"

# Crear el directorio si no existe
if [ -d "$NUEVO_DIR" ]; then
    echo "El directorio ya existe: $NUEVO_DIR"
else
    mkdir -p "$NUEVO_DIR"
    echo "Directorio creado: $NUEVO_DIR"
fi
