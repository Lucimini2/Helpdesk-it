# Dockerfile (para backend PHP)
FROM php:8.1-fpm

# Instalar dependencias necesarias y extensiones PHP
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar el código backend
COPY backend/ /var/www/html/backend/

# Copiar el código frontend, ya que el PHP sirve las vistas
COPY frontend/ /var/www/html/

# Cambiar propietario de los archivos al usuario www-data
RUN chown -R www-data:www-data /var/www/html

# Establecer el directorio de trabajo
WORKDIR /var/www/html
