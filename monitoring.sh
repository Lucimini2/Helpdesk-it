#!/bin/bash

set -e

echo "Creando espacio de monitorización..."
kubectl create namespace monitoring

echo "Instalando Helm..."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "Agregando repositorio de Prometheus Community y actualizando repos repos..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Desplegando prometheus-stack en el namespace monitoring..."
helm install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set prometheus.prometheusSpec.maximumStartupDurationSeconds=120

echo "Despliegue completado."

echo ""
echo "Para acceder a Grafana, ejecuta el siguiente comando en otro terminal:"
echo "kubectl port-forward -n monitoring svc/prometheus-stack-grafana 3000:80"
echo "Luego accede a: http://localhost:3000"
echo "Usuario: admin"
echo -n "Contraseña: "
kubectl get secret --namespace monitoring prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
echo ""

echo ""
echo "Para acceder a Prometheus, ejecuta el siguiente comando en otro terminal:"
echo "kubectl port-forward -n monitoring svc/prometheus-stack-kube-prom-prometheus 9090:9090"
echo "Luego accede a: http://localhost:9090"
