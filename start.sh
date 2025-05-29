#!/bin/bash

# Colores para mensajes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Script de despliegue Helpdesk-IT en Minikube ===${NC}"

# 1. Limpieza total
echo -e "\n${GREEN}[1/8] Limpiando entorno Minikube...${NC}"
# minikube delete --all --purge

# 2. Iniciar cluster con montaje completo en /app
echo -e "\n${GREEN}[2/8] Iniciando cluster Minikube con montaje /app...${NC}"
minikube start --driver=docker --cpus=2 --memory=4g --disk-size=20g --mount --mount-string=/home/lucia/proyecto/Helpdesk-it:/app

# 3. Habilitar addons
echo -e "\n${GREEN}[3/8] Habilitando addons...${NC}"
minikube addons enable ingress
minikube addons enable metrics-server

# 4. Configurar entorno Docker
echo -e "\n${GREEN}[4/8] Configurando Docker para Minikube...${NC}"
eval $(minikube docker-env)

# 5. Construir imágenes Docker
echo -e "\n${GREEN}[5/8] Construyendo imágenes Docker autocontenidas...${NC}"
docker build -t helpdesk-php -f Dockerfile.php . || { echo -e "${RED}Error construyendo imagen PHP${NC}"; exit 1; }

if [[ -f Dockerfile.nginx ]]; then
  docker build -t helpdesk-nginx -f Dockerfile.nginx . || { echo -e "${RED}Error construyendo imagen Nginx${NC}"; exit 1; }
else
  echo -e "${YELLOW}→ No se encontró Dockerfile.nginx. Usando nginx:latest por defecto.${NC}"
fi

# 6. Desplegar en Kubernetes
echo -e "\n${GREEN}[6/8] Desplegando aplicaciones...${NC}"
kubectl apply -f k8s/configmaps.yaml
kubectl apply -f k8s/mysql-deployment.yaml

echo -e "${YELLOW}Esperando a que MySQL esté listo (máx 2 minutos)...${NC}"
kubectl wait --for=condition=ready pod -l app=mysql --timeout=120s

kubectl apply -f k8s/php-deployment.yaml
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/phpmyadmin-deployment.yaml
kubectl apply -f k8s/ingress.yaml

# 7. Inicializar BD
echo -e "\n${GREEN}[7/8] Inicializando base de datos...${NC}"
MYSQL_POD=$(kubectl get pods -l app=mysql -o jsonpath="{.items[0].metadata.name}")
kubectl exec -i "$MYSQL_POD" -- mysql -u root -proot helpdesk < db/init.sql

# 8. Mostrar información de acceso
echo -e "\n${GREEN}[8/8] Configuración completada!${NC}"

echo -e "\n${YELLOW}=== URLs de acceso ==="
echo -e "Ejecuta en terminales separadas:"
echo -e "1. kubectl port-forward svc/nginx-service 8080:80"
echo -e "2. kubectl port-forward svc/phpmyadmin-service 8081:80"
echo -e "\nAcceso:"
echo -e "Cliente:      http://localhost:8080/cliente/"
echo -e "Admin:        http://localhost:8080/admin/"
echo -e "phpMyAdmin:   http://localhost:8081/${NC}"
