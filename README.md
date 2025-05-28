# HelpDesk IT - Sistema de Gestión de Incidencias 🚀

![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![phpMyAdmin](https://img.shields.io/badge/phpMyAdmin-6C78AF?style=for-the-badge&logo=php&logoColor=white)

## 🧩 Descripción del Proyecto

**HelpDesk IT** es una plataforma profesional de gestión de incidencias técnicas orientada a entornos empresariales. Ofrece:

- **Interfaz dual:** cliente + administrador  
- **Contenerización completa:** Docker y Kubernetes  
- **Base de datos administrable:** MySQL + phpMyAdmin  
- **Automatización de backups** vía `cronjobs` en Kubernetes  
- **Escalabilidad:** arquitectura pensada para microservicios  
- **Monitorización opcional** con Prometheus y Grafana

---

## ✨ Características Clave

✅ Gestión completa de tickets (crear, consultar, actualizar, eliminar)  
✅ Interfaces separadas para usuarios y administradores  
✅ Exportación de reportes y control del estado  
✅ Base de datos gestionable con phpMyAdmin  
✅ Backups automáticos con `mysqldump` + cron  
✅ Despliegue orquestado en Minikube (Kubernetes local)  
✅ Preparado para monitorización del sistema (CPU, RAM, contenedores)

---

## 🛠️ Tecnologías Utilizadas

| Componente       | Tecnología              |
|------------------|--------------------------|
| Frontend         | HTML5, CSS3              |
| Backend          | PHP 8.2                  |
| Base de Datos    | MySQL 8                  |
| Admin DB         | phpMyAdmin               |
| Servidor Web     | Nginx                    |
| Contenerización  | Docker + Docker Compose  |
| Orquestación     | Kubernetes (Minikube)    |
| Automatización   | Shell Scripting + Cron   |
| Monitorización   | Prometheus/Grafana (opcional) |

---

## 📂 Estructura del Proyecto

```
Helpdesk-it/
├── Dockerfile
├── Dockerfile.php
├── README.md
├── backend/
│   ├── actualizar-tickets.php
│   ├── cargar-tickets.php
│   └── crear-ticket.php
├── copiar_backups.sh
├── db/
│   └── init.sql
├── docker/
│   └── nginx/
│       └── default.conf
├── docker-compose.yml
├── frontend/
│   ├── admin/
│   │   ├── css/
│   │   │   └── styles.css
│   │   ├── index.php
│   │   └── nuevo-ticket.php
│   ├── backend/
│   ├── cliente/
│   │   ├── css/
│   │   │   └── styles.css
│   │   ├── index.php
│   │   └── nuevo-ticket.php
│   └── shared/
│       └── css/
│           └── common.css
├── k8s/
│   ├── configmaps.yaml
│   ├── mysql-backup-cronjob.yaml
│   ├── mysql-deployment.yaml
│   ├── nginx-deployment.yaml
│   ├── php-deployment.yaml
│   └── phpmyadmin-deployment.yaml
├── limpio.sh
├── monitoring.sh
├── mysql-backups/
├── start.sh
└── verificar_backups.sh
```
---

## ⚙️ Requisitos Previos

- Docker Desktop v24.0+
- Docker Compose v2.20+
- Minikube v1.32+
- kubectl v1.28+
- Git
- WSL (si usas Windows)

---

## Instalación 🚀

### 1. Helpdesk y Base de datos

```bash
# 1. Clonar repositorio
git clone https://github.com/Lucimini2/Helpdesk-it.git
cd helpdesk-it

# 2. Ejecutar entorno inicial
chmod +x start.sh
./start.sh

# 3. Verificar pods
kubectl get pods

# 4. Ejecutar en terminales separadas
kubectl port-forward svc/nginx-service 8080:80
kubectl port-forward svc/phpmyadmin-service 8081:80

# 5. Acceder a la aplicación
# - Cliente: http://localhost:8080/cliente
# - Admin: http://localhost:8080/admin
# - phpMyAdmin: http://localhost:8081
# (Usuario/Password definidos en archivo .env o init.sql)
```
### 2. Backups automáticos

```bash
#  Crear y preparar directorio
minikube ssh
sudo mkdir -p /mnt/data/mysql-backups
sudo chown -R docker:docker /mnt/data/mysql-backups
exit

# Aplicar CronJob en Kubernetes
kubectl apply -f k8s/mysql-backup-cronjob.yaml

# Prueba 
kubectl create job --from=cronjob/mysql-backup mysql-backup-test

# Logs de backup
kubectl logs job/mysql-backup-test

# Copiar backup al directorio del proyecto
./copiar_backups.sh 

# Verificar backups
./verificar_backups.sh 

# Programar copias/validaciones con cron
crontab -e

# Agrega al final:

    # Copia los backups todos los días a las 02:00 AM
    0 2 * * * /home/lucia/proyecto/Helpdesk-it/copiar_backups.sh >> /home/lucia/proyecto/Helpdesk-it/copiar_backups.log 2>&1

    # Verifica los backups todos los días a las 02:05 AM
    5 2 * * * /home/lucia/proyecto/Helpdesk-it/verificar_backups.sh >> /home/lucia/proyecto/Helpdesk-it/verificar_backups.log 2>&1


# Comprobaciones con: 
crontab -l
systemctl status cron
ls -lh /home/lucia/proyecto/Helpdesk-it/mysql-backups
kubectl get jobs

minikube ssh
ls -lh /mnt/data/mysql-backups
exit
```
### 3. Monitorización con Grafana + Prometheus 

```bash
# Crear espacio de monitorización
chmod +x monitoring.sh 
./monitoring.sh 

# Comprobar:
kubectl get pods -n monitoring

# Acceder a Grafana:
kubectl port-forward -n monitoring svc/prometheus-stack-grafana 3000:80
# Accede: 
http://localhost:3000
# Usuario: 
admin
# Contraseña: prom-operator
kubectl get secret --namespace monitoring prometheus-stack-grafana \
  -o jsonpath="{.data.admin-password}" | base64 --decode && echo

# Acceder a Prometheus:
kubectl port-forward -n monitoring svc/prometheus-stack-kube-prom-prometheus 9090:9090
# Accede: 
http://localhost:9090
```

## 💻 Uso del Sistema

### 👥 Clientes

Los usuarios pueden:

- 📝 Crear nuevos tickets de soporte técnico
- 👀 Consultar el estado actual de cada incidencia (Abierto, En progreso, Cerrado)
- 📂 Acceder al historial de tickets enviados
- 🔄 Recibir actualizaciones del estado y respuestas desde el panel de cliente

Acceso: [http://localhost:8080/cliente](http://localhost:8080/cliente)

---

### 🛠️ Administradores

Los administradores disponen de un panel completo para:

- 📋 Visualizar todos los tickets enviados por los usuarios
- ✏️ Modificar el estado del ticket (Abierto → En progreso → Cerrado)
- 🗑️ Eliminar tickets resueltos o duplicados
- 📤 Exportar tickets en formatos CSV para informes y seguimiento
- 🔍 Filtrar y buscar tickets por estado, fecha o cliente

Acceso: [http://localhost:8080/admin](http://localhost:8080/admin)

## Contribuir 🤝

```bash
# Clona el proyecto
git clone https://github.com/Lucimini2/Helpdesk-it.git

# Crea nueva rama
git checkout -b feature/mi-mejora

# Sube cambios
git commit -m "Añadida funcionalidad XYZ"
git push origin feature/mi-mejora

# Abre un Pull Request 🚀
```

## Licencia 📜
Este proyecto está bajo licencia MIT - ver LICENSE para más detalles.
