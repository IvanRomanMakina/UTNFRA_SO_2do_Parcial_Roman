#!/bin/bash

#Configurar particiones en /dev/sda
sudo fdisk /dev/sda <<EOF
n
p

+2G
t
8E
n
p

+1G
t
2
8E
w
EOF

#LImpiar firmas de sistema de archivos anteriores
sudo wipefs -a /dev/sda1 /dev/sda2

#Crear volumenes fisicos en las nuevas particiones
sudo pvcreate /dev/sda1 /dev/sda2

#Mostrar volumenes fisicos
sudo pvs

#Crear grupos de volumenes
sudo vgcreate vg_datos /dev/sda1
sudo vgcreate vg_temp /dev/sda2

#Mostrar grupos de volumenes
sudo vgs

#Crear volumenes logicos
sudo lvcreate -L 5M vg_datos -n lv_docker
sudo lvcreate -L 1.5G vg_datos -n lv_workareas
sudo lvcreate -L 512M vg_temp -n lv_swap

#Mostrar volumenes logicos
sudo lvs

#Listar particiones
sudo fdisk -l

#FOrmatear los vulumenes logicos
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_workareas

#Mostrar bloques de dispositivos
sudo lsblk

#COnfigurar swap
sudo mkswap /dev/vg_temp/lv_swap

#Crear directorios de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

#Montar volumenes logicos
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/
sudo mount /dev/mapper/vg_datos-lv_workareas /work/

#Activar swap
sudo swapon /dev/vg_temp/lv_swap

#Mostrar sistemas de archivos montados
df -h

#Reiniciar y verificar estado de Docker
sudo systemctl restart docker
sudo systemctl status docker



