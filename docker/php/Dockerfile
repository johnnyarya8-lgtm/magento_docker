FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    wget \
    nano \
    vim \
    cron \
    default-mysql-client \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    libxslt1-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libfreetype6-dev \
    libonig-dev \
    libsodium-dev

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

RUN docker-php-ext-install \
    bcmath \
    ftp \
    gd \
    intl \
    mysqli \
    pdo_mysql \
    soap \
    sockets \
    xsl \
    zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html
