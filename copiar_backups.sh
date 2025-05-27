#!/bin/bash

# Usar ruta absoluta en lugar de ~
LOCAL_BACKUP_DIR="/home/lucia/proyecto/Helpdesk-it/mysql-backups"
MINIKUBE_BACKUP_DIR="/mnt/data/mysql-backups"

mkdir -p "$LOCAL_BACKUP_DIR"

echo "Listando archivos en Minikube..."
FILES=$(minikube ssh "find $MINIKUBE_BACKUP_DIR -type f \( -name '*.sql' -o -name '*.log' \)" | tr -d '\r')

echo "Copiando backups desde Minikube..."

for file in $FILES; do
    echo "Copiando $file"
    # Extraemos solo el nombre del archivo para no crear subdirectorios
    filename=$(basename "$file")
    # Guardamos el contenido en el directorio local
    minikube ssh "cat \"$file\"" > "$LOCAL_BACKUP_DIR/$filename"
done

echo "Copias de backups actualizadas en $LOCAL_BACKUP_DIR"
