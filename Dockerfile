FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip \
    && docker-php-ext-install pdo pdo_mysql zip

COPY src/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
