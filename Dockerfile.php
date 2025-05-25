FROM php:8.2-fpm

# Instalar dependencias y herramientas necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    fcgiwrap \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurar PHP-FPM para escuchar en todos los interfaces
RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.d/www.conf

# Crear script de healthcheck para PHP-FPM
RUN echo '#!/bin/sh\n\
SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \n\
if ! cgi-fcgi -bind -connect 127.0.0.1:9000; then\n\
  exit 1\n\
fi' > /usr/local/bin/php-fpm-healthcheck \
&& chmod +x /usr/local/bin/php-fpm-healthcheck

# Crear endpoint de healthcheck
RUN echo '<?php header("Content-Type: text/plain"); echo "pong"; ?>' > /var/www/html/ping

WORKDIR /var/www/html