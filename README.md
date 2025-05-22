# HelpDesk IT - Sistema de Gestión de Incidencias 🚀

![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)

## Descripción del Proyecto

Plataforma profesional **HelpDesk** para gestión de incidencias IT con:

- **Interfaz dual**: Panel de administración y vista cliente
- **Stack moderno**: PHP 8.2 + MySQL 8 + Nginx
- **Contenerización**: Docker + Kubernetes (Minikube)
- **Escalabilidad**: Arquitectura preparada para microservicios

## Características Clave ✨

✅ Gestión completa de tickets (CRUD)  
✅ Filtrado por estados (Abierto/En progreso/Cerrado)  
✅ Panel administrativo con funcionalidades avanzadas  
✅ Base de datos gestionable via phpMyAdmin 

## Tecnologías Utilizadas 🛠️

| Componente       | Tecnología           |
|------------------|----------------------|
| Frontend         | HTML5, CSS3         |
| Backend          | PHP 8.2             |
| Base de Datos    | MySQL 8             |
| Servidor Web     | Nginx               |
| Contenerización  | Docker + Docker Compose |
| Orquestación     | Kubernetes (Minikube) |

## Requisitos Previos 📋

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (v24.0+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.20+)
- [Minikube](https://minikube.sigs.k8s.io/docs/) (v1.32+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (v1.28+)

## Estructura del Proyecto 📂
```plaintext
helpdesk-it/
│
├── backend/          🖥️ Código PHP (API, gestión de tickets)  
├── frontend/         🌐 Frontend dividido en:  
│     ├─ admin/       🎛️ Panel administrativo  
│     └─ cliente/     👤 Interfaz cliente  
├── db/               🗄️ Scripts y esquema de la base de datos  
├── docker/           🐳 Configuraciones para contenedores Docker  
├── docker-compose.yml📦 Orquestación con Docker Compose  
├── k8s/              ☸️ Manifiestos y configuraciones Kubernetes  
├── Dockerfile*       🏗️ Definiciones para crear imágenes Docker  
├── limpio.sh         🧹 Script para limpiar recursos temporales  
├── start.sh          ▶️ Script para iniciar servicios  
└── README.md         📖 Documentación del proyecto
```

## Instalación 🚀

### 1: Docker Compose + kubernetes 

```bash
# 1. Clonar repositorio
git clone https://github.com/tu-usuario/helpdesk-it.git
cd helpdesk-it

# 2. Ejecutar start.sh
chmod +x start.sh
./start.sh

# 3. Abrir los puertos
kubectl port-forward svc/nginx-service 8080:80
kubectl port-forward svc/phpmyadmin-service 8081:80

# 4. Acceder a:
# - Cliente: http://127.0.0.1:33225/cliente/
# - Admin: http://127.0.0.1:33225/admin/
# - phpMyAdmin: http://127.0.0.1:8081/
```

## Uso del Sistema 💻 

### Para Clientes

- Crear nuevos tickets
- Ver estado de incidencias
- Consultar historial

### Para Administradores

- Gestionar todos los tickets
- Cambiar estados (Abierto → En progreso → Cerrado)
- Eliminar tickets
- Exportar reportes

## Contribuir 🤝

- Haz fork del proyecto
- Crea tu rama (git checkout -b feature/awesome-feature)
- Haz commit de tus cambios (git commit -am 'Add awesome feature')
- Haz push a la rama (git push origin feature/awesome-feature)
- Abre un Pull Request

## Licencia 📜
Este proyecto está bajo licencia MIT - ver LICENSE para más detalles.
