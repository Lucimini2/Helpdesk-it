#!/bin/bash

set -e  # Salir si hay error

echo "=== Eliminando minikube y purgando todo..."
minikube delete --all --purge || true

echo "=== Iniciando minikube..."
minikube start

echo "=== Construyendo imagen PHP custom localmente..."
# Asegúrate de estar en el directorio raíz de tu proyecto donde está Dockerfile.php
docker build -t helpdesk-php:custom -f Dockerfile.php .

echo "=== Aplicando manifiestos de Kubernetes..."
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/php-deployment.yaml
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/phpmyadmin-deployment.yaml
kubectl apply -f k8s/configmaps.yaml

echo "=== Esperando a que los pods estén en estado Running..."
kubectl wait --for=condition=Ready pod -l app=mysql --timeout=120s
kubectl wait --for=condition=Ready pod -l app=php --timeout=120s
kubectl wait --for=condition=Ready pod -l app=nginx --timeout=120s
kubectl wait --for=condition=Ready pod -l app=phpmyadmin --timeout=120s

echo "=== Listado de pods actuales:"
kubectl get pods

echo "=== Servicios desplegados y puertos:"
kubectl get svc

echo ""
echo "=== Instrucciones finales para acceder a tus servicios:"
echo "1) En una terminal, corre para nginx:"
echo "   kubectl port-forward svc/nginx-service 8080:80"
echo "   y abre http://127.0.0.1:8080/cliente/ o /admin/"
echo ""
echo "2) En otra terminal, corre para phpMyAdmin:"
echo "   kubectl port-forward svc/phpmyadmin-service 8081:80"
echo "   y abre http://127.0.0.1:8081/"
echo "   Usuario: root"
echo "   Contraseña: root"
echo ""

echo "=== Si necesitas reiniciar un deployment después de cambios, usa:"
echo "kubectl rollout restart deployment/<nombre>"
echo "Ejemplo: kubectl rollout restart deployment/php"

echo "=== ¡Listo! Proyecto desplegado y funcional."
