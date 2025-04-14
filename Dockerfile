# Imagen base con PHP-FPM
FROM php:8.2-fpm

# Instalar dependencias y extensión mysqli
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Crear directorio para la aplicación
RUN mkdir -p /var/www/html

# Copiar el código PHP
COPY backend/index.php /var/www/html/

# Dar permisos adecuados
RUN chown -R www-data:www-data /var/www/html