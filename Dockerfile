# Utilise l'image PHP 8.2 avec FPM
FROM php:8.2-fpm

# Installe les dépendances système
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libonig-dev

# Installe les extensions PHP requises
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath

# Installe Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crée un répertoire pour l'application
WORKDIR /var/www

# Crée le répertoire de stockage et change les permissions
RUN mkdir -p /var/www/storage \
    && chown -R www-data:www-data /var/www/storage

# Expose le port 9000 et démarre PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
