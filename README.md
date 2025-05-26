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
`helpdesk-it/`  
├── `backend/` *(Lógica PHP)* → `api.php`, `cargar-tickets.php`, ...  
├── `frontend/` → `admin/` (panel), `cliente/` (UI)  
├── `docker/` → `nginx/default.conf`, `php/` (configs)  
├── `k8s/` *(Kubernetes)* → `deployments/`, `services/`  
├── `db/` → `init.sql` *(esquema DB)*  
└── `docker-compose.yml` *(orquestación)*


## Instalación 🚀

### 1: Docker Compose + kubernetes 

```bash
# 1. Clonar repositorio
git clone https://github.com/tu-usuario/helpdesk-it.git
cd helpdesk-it

# 2. Iniciar servicios
- minikube start --driver=docker
- sudo docker-compose up -d --build
- minikube addons enable ingress
- kubectl apply -f k8s/.

# 3. Subir imagenes
- eval $(minikube docker-env)
- docker-compose build

# 4. Acceder a:
# - Cliente: http://localhost:8080/cliente
# - Admin: http://localhost:8080/admin
# - phpMyAdmin: http://localhost:8083
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