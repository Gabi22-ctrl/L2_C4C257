#!/bin/bash

#verificar si el usuario es root
if [ "$(id -u)" -ne 0 ]; then
 echo "Error, el usuario no es root"
 exit
fi

#Parámetros
usuario=$1
grupo=$2
ruta=$3
#Verificacion de ruta
if [ ! -e "$ruta" ]; then
 echo "el archivo no existe $(date) "
 exit
fi
#Verificar que el grupo existe o crearlo
if [ $(cat /etc/group | grep $grupo | cut -d ':' -f1) ]; then  
  echo "El grupo solicitado ya existe $(date)"
else
 addgroup "$grupo"
fi 

# Verificar que el usuario exista
if grep -q "^$usuario:" /etc/passwd; then
 echo "El usuario ya existe"
 adduser $usuario $grupo
else
 echo "Creando usuario"
 adduser $usuario
 adduser $usuario $grupo  
fi

#Hacer que el archivo pertenezca al usuario y al grupo dados
chown "$usuario":"$grupo" "$ruta"

#Modificaciòn de permisos
chmod 740 "$ruta"



 

