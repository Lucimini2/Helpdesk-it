#!/bin/bash

# Parar y eliminar contenedores, imágenes, volúmenes y orígenes huérfanos
docker-compose down --rmi all --volumes --remove-orphans

# Limpiar sistema docker (elimina imágenes, contenedores, volúmenes no usados)
docker system prune -af --volumes

# Reconstruir imágenes sin cache
#docker-compose build --no-cache

# Levantar los servicios en modo detach (en segundo plano)
#sudo docker-compose up -d
