#!/bin/bash

LOCAL_BACKUP_DIR=~/proyecto/Helpdesk-it/mysql-backups

echo "Comprobando archivos en $LOCAL_BACKUP_DIR"

if [ ! -d "$LOCAL_BACKUP_DIR" ]; then
    echo "No existe el directorio local de backups."
    exit 1
fi

# Listamos los archivos y sus tamaños
ls -lh "$LOCAL_BACKUP_DIR"

# Opcional: revisar el contenido de un archivo para confirmar
echo -e "\nMostrando primeras líneas de un backup para verificación:"
head -n 20 "$LOCAL_BACKUP_DIR"/helpdesk-*.sql

echo -e "\nVerificación finalizada."
