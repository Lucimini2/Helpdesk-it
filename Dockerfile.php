# Dockerfile.php
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Forzar que PHP-FPM escuche en todas las interfaces
RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.d/www.conf

# Copiar el código backend
COPY backend/ /var/www/html/backend/

# Copiar el frontend también (si lo usa PHP)
COPY frontend/ /var/www/html/

WORKDIR /var/www/html
