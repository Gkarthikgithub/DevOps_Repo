# Use official PHP image with necessary extensions
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer globally
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Create Yii2 app in src/ folder
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic src/

# Set document root to src/web
RUN sed -i 's|/var/www/html|/var/www/html/src/web|g' /etc/apache2/sites-available/000-default.conf

# Set permissions (optional, useful for Yii2 runtime/logs/assets folders)
RUN chown -R www-data:www-data /var/www/html/src \
    && chmod -R 755 /var/www/html/src

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
