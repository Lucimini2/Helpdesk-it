FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

RUN mkdir -p /var/www/html/{frontend,backend}
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html