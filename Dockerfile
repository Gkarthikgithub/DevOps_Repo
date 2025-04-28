FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libzip-dev \
    && docker-php-ext-install pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy app files
COPY src/ /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Install Yii2 PHP dependencies
RUN composer install --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose port 80
EXPOSE 80

# Healthcheck (optional, good for Swarm!)
HEALTHCHECK CMD curl --fail http://localhost || exit 1
