#!/bin/bash

# Función para mostrar mensajes con formato
function info() {
    echo -e "\e[1;34mℹ️  $1\e[0m"
}

function success() {
    echo -e "\e[1;32m✅ $1\e[0m"
}

function warn() {
    echo -e "\e[1;33m⚠️  $1\e[0m"
}

# 1. Limpieza inicial
info "1/7 - Limpiando entorno Minikube..."
minikube delete --all --purge

# 2. Iniciar Minikube
info "2/7 - Iniciando Minikube..."
minikube start --driver=docker

# 3. Configurar Docker (CRUCIAL - debe estar antes de construir imágenes)
info "3/7 - Configurando Docker en Minikube..."
eval $(minikube docker-env)

# 4. Construir imágenes con tags específicos
info "4/7 - Construyendo imágenes Docker..."
docker build -t local/helpdesk-php:v1 -f Dockerfile.php .
docker build -t local/helpdesk-nginx:v1 -f Dockerfile .

# Verificar que las imágenes existen en Minikube
info "  - Verificando imágenes en Minikube..."
minikube ssh docker images | grep helpdesk

# 5. Copiar archivos
info "5/7 - Copiando archivos a Minikube..."
minikube ssh "sudo mkdir -p /data/frontend /data/backend && sudo chmod -R 777 /data"

info "  - Sincronizando frontend..."
tar -czf - -C ./frontend . | minikube ssh "sudo tar -xzf - -C /data/frontend"

info "  - Sincronizando backend..."
tar -czf - -C ./backend . | minikube ssh "sudo tar -xzf - -C /data/backend"

success "  Archivos copiados correctamente"

# 6. Desplegar recursos (con modificación de imágenes)
info "6/7 - Desplegando recursos en Kubernetes..."

# Aplicar configmaps y servicios sin modificar
kubectl apply -f k8s/configmaps.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/phpmyadmin-deployment.yaml

# Aplicar deployments con imágenes modificadas
kubectl apply -f <(sed -E 's|image: helpdesk-php([^ ]*)?|image: local/helpdesk-php:v1|' k8s/php-deployment.yaml)
kubectl apply -f <(sed -E 's|image: helpdesk-nginx([^ ]*)?|image: local/helpdesk-nginx:v1|' k8s/nginx-deployment.yaml)

# 7. Esperar a que los pods estén listos con mayor tiempo de espera
info "7/7 - Esperando a que los pods estén listos..."
kubectl wait --for=condition=Ready pods --all --timeout=600s

# Verificar estado de los healthchecks
info "Verificando healthchecks..."
kubectl get pods -o wide
kubectl describe pods | grep -A 10 "Events:"

# Mostrar estado final
echo ""
success "🎉 Despliegue completado!"
echo ""
echo "Para acceder a los servicios:"
echo "  Aplicación:    kubectl port-forward svc/nginx-service 8080:80"
echo "  PHPMyAdmin:    kubectl port-forward svc/phpmyadmin-service 8081:80"
echo ""
info "Estado actual del cluster:"
kubectl get pods,svc