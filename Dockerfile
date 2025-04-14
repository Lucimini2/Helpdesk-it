# Imagen base con PHP y Apache
FROM php:8.2-apache

# Instalar extensión mysqli para PHP
RUN docker-php-ext-install mysqli

# Copiar el código del backend al directorio raíz de Apache
COPY backend/ /var/www/html/

# Dar permisos adecuados
RUN chown -R www-data:www-data /var/www/html

# Habilitar mod_rewrite si necesitas URLs limpias en el futuro
RUN a2enmod rewrite
