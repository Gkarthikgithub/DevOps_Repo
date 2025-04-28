# Base image with PHP and extensions
FROM php:8.1-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip \
    libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Create Yii2 app inside 'src'
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic src

# Install yii2-bootstrap5 extension
WORKDIR /var/www/html/src
RUN composer require yiisoft/yii2-bootstrap5

# Set permissions (important for runtime and assets)
RUN chown -R www-data:www-data /var/www/html/src \
    && chmod -R 755 /var/www/html/src

# Apache config - serve from src/web
ENV APACHE_DOCUMENT_ROOT /var/www/html/src/web

# Adjust Apache config
RUN sed -ri -e 's!/var/www/html!/var/www/html/src/web!g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/src/web!g' /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
