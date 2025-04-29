FROM yiisoftware/yii2-php:7.4-apache

# Set working directory
WORKDIR /app

# Copy your app source code
COPY . /app

# Optional: Install PHP dependencies using Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set proper permissions (optional)
RUN chown -R www-data:www-data /app
