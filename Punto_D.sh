#!/bin/bash

#Cambiar a la ruta del repositorio
cd ~/repogit/UTN-FRA_SO_Examenes/202406/ansible

#Crear carpetas
sudo mkdir -p /tmp/2do_parcial/alumno /tmp/2do_parcial/equipo

#Crear templates
echo "Nombre: Ivan Apellido: Roman" > /tmp/2do_parcial/alumno/datos_alumno.txt
echo "Division: 115" >> /tmp/2do_parcial/alumno/datos_alumno.txt

echo "IP: $(hostname -I | awk '{print $1}')" > /tmp/2do_parcial/equipo/datos_equipo.txt
echo "Distribucion $(lsb_release -d | awk -F'\t' '{print $2}')" >> /tmp/2do_parcial/equipo/datos_equipo.txt
echo "Cantidad de Cores: $(nproc)" >> /tmp/2do_parcial/equipo/datos_equipo.txt

#COnfigurar sudoers
echo "%2PSupervisores ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/2PSupervisores

cd /home/vagrant
