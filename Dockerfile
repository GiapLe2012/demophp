FROM php:7.0-apache

RUN apt-get update && \
    apt-get install -y \
    libmcrypt-dev \
    git \
    zip unzip \
    libicu-dev \
    zlib1g-dev \
    php5 \
    php5-fpm \
    php5-pear \
    php5-dev \
    php5-apc \
    php5-common \
    php5-json \
    php5-memcache \
    php5-memcached  \
    php5-xsl \
    php5-mcrypt \
    php5-mysql \
    php5-cli \
    php5-gd \
    php5-intl \
    php5-curl \ 
    && docker-php-ext-install -j$(nproc) pdo_mysql mysql mysqli iconv mcrypt opcache && \
    apt-get clean

COPY myapp /var/www/html/
