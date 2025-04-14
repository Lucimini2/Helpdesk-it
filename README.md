# PROYECTO-FINAL

## Titulo

Plataforma HelpDesk para Gestión de Incidencias IT con Docker

## Descripción

Este proyecto consiste en el desarrollo de un **Sistema HelpDesk** para la gestión de incidencias IT, implementado usando Docker y Kubernetes. La plataforma está basada en un stack tecnológico profesional compuesto por **PHP**, **MySQL**, y **Nginx**, y está lista para ser desplegada en entornos contenerizados. El proyecto incluye:

- **Interfaz web responsive** (HTML/CSS)
- **Backend en PHP** con acceso a una base de datos MySQL
- **Gestión de tickets** de IT
- **Integración con phpMyAdmin** para gestionar la base de datos

El objetivo de este proyecto es proporcionar una solución escalable que permita ampliaciones futuras, como APIs y microservicios, cumpliendo con los estándares profesionales.

## Tecnologías

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** PHP
- **Base de Datos:** MySQL
- **Contenerización:** Docker, Kubernetes (Minikube)
- **Proxy inverso:** Nginx
- **Gestión de base de datos:** phpMyAdmin

## Requisitos Previos

Antes de empezar, asegúrate de tener instalados y configurados los siguientes programas:

- [Docker](https://www.docker.com/get-started) (para crear contenedores)
- [Docker Compose](https://docs.docker.com/compose/install/) (para orquestar los contenedores)
- [Minikube](https://minikube.sigs.k8s.io/docs/) (para Kubernetes local)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (herramienta de línea de comandos de Kubernetes)

## Estructura del Proyecto

La estructura del proyecto es la siguiente:

helpdesk-it-ticket-management/
├── backend/
│   └── index.php  # Backend PHP que maneja la lógica de los tickets
├── frontend/
│   └── index.html  # Interfaz web para mostrar los tickets
│   └── css/
│       └── styles.css  # Estilos CSS para la interfaz
├── db/
│   └── init.sql  # Script SQL para inicializar la base de datos
├── docker/
│   ├── nginx/
│   │   └── default.conf  # Configuración de Nginx para el proxy inverso
│   └── Dockerfile  # Dockerfile para crear la imagen PHP + Apache
├── k8s/
│   ├── mysql-deployment.yaml  # Manifiesto de Kubernetes para MySQL
│   ├── php-deployment.yaml  # Manifiesto de Kubernetes para PHP
│   ├── nginx-deployment.yaml  # Manifiesto de Kubernetes para Nginx
│   ├── phpmyadmin-deployment.yaml  # Manifiesto de Kubernetes para phpMyAdmin
│   └── ingress.yaml  # Configuración de Ingress para exponer servicios
└── docker-compose.yml  # Orquestación de contenedores con Docker Compose

## Instalación

### Paso 1: Clonar el repositorio

Clona este repositorio en tu máquina local:

```bash
git clone "url"
cd PROYECTO FINAL
code .
```

### Paso 2: Levantar el entorno local con Docker Compose

Para levantar el entorno localmente con Docker Compose, ejecuta el siguiente comando:

```bash
docker-compose up -d --build
```
Este comando levantará los siguientes servicios:

PHP + Apache: Servirá el backend PHP.
MySQL: Base de datos para los tickets.
phpMyAdmin: Interfaz web para gestionar la base de datos.

Una vez ejecutado, podrás acceder a los siguientes servicios:

Frontend: http://localhost:8080
phpMyAdmin: http://localhost:8081

### Paso 3: Configurar Kubernetes

Si deseas usar Kubernetes para despliegues más escalables, primero asegúrate de tener Minikube configurado. Luego, puedes desplegar los servicios de la plataforma ejecutando los siguientes comandos:

1. Inicializa Minikube:

    ```bash
    minikube start
    ```

2. Aplica los manifiestos de Kubernetes:

    ```bash
    kubectl apply -f k8s/mysql-deployment.yaml
    kubectl apply -f k8s/php-deployment.yaml
    kubectl apply -f k8s/nginx-deployment.yaml
    kubectl apply -f k8s/phpmyadmin-deployment.yaml
    kubectl apply -f k8s/ingress.yaml
    ```

3. Obtén la URL del Ingress configurado:

    ```bash
    minikube service nginx-service --url
    ```

4. Agrega la URL proporcionada al archivo `/etc/hosts` para acceder a `helpdesk.local`.

## Descripción de Archivos

1. **backend/index.php**  
   Este archivo maneja las solicitudes HTTP para recuperar los tickets desde la base de datos MySQL y devolverlos como JSON al frontend.

2. **frontend/index.html**  
   La interfaz web que muestra la lista de tickets. Se conecta al backend usando JavaScript y los muestra de manera responsiva en la página.

3. **frontend/css/styles.css**  
   El archivo CSS para los estilos de la página, asegurando que se vea bien en diferentes dispositivos.

4. **db/init.sql**  
   Script SQL que se ejecuta al iniciar el contenedor MySQL para crear la base de datos `helpdesk`, la tabla `tickets` y cargar algunos tickets de ejemplo.

5. **docker/nginx/default.conf**  
   Configuración de Nginx como proxy inverso, redirigiendo las solicitudes a PHP para el procesamiento de las páginas.

6. **Dockerfile**  
   Archivo para construir la imagen de Docker del contenedor PHP + Apache, con la extensión mysqli para conectar con MySQL.

7. **docker-compose.yml**  
   Orquesta los contenedores de PHP, MySQL y phpMyAdmin en un solo comando para levantarlos fácilmente en tu entorno local.

8. **k8s/mysql-deployment.yaml**  
   Manifiesto de Kubernetes para desplegar MySQL y exponerlo a través de un Service.

9. **k8s/php-deployment.yaml**  
   Despliegue de PHP con Apache en Kubernetes, configurando un contenedor que sirve los archivos PHP.

10. **k8s/nginx-deployment.yaml**  
    Despliegue de Nginx en Kubernetes para actuar como proxy inverso, dirigiendo el tráfico hacia el servicio PHP.

11. **k8s/phpmyadmin-deployment.yaml**  
    Despliegue de phpMyAdmin en Kubernetes, permitiendo gestionar la base de datos MySQL a través de una interfaz web.

12. **k8s/ingress.yaml**  
    Manifiesto de Ingress para configurar la exposición de los servicios a través de una URL accesible desde Minikube.

## Contribuir

Si deseas contribuir a este proyecto, por favor sigue estos pasos:

1. Forkea el repositorio.
2. Crea una nueva rama para tu característica o corrección (`git checkout -b feature/nueva-caracteristica`).
3. Realiza tus cambios y haz commit (`git commit -am 'Añadir nueva característica'`).
4. Haz push a tu rama (`git push origin feature/nueva-caracteristica`).
5. Crea un Pull Request explicando tus cambios.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
