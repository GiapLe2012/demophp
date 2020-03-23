FROM php:7.2-cli

RUN yum update && \
    yum install -y \
    libmcrypt-dev \
    git \
    zip unzip \
    libicu-dev \
    zlib1g-dev \
    php \
    php-fpm \
    php-pear \
    php-dev \
    php-apc \
    php-common \
    php-json \
    php-memcache \
    php-memcached  \
    php-xsl \
    php-mcrypt \
    php-mysql \
    php-cli \
    php-gd \
    php-intl \
    php-curl \ 
    && docker-php-ext-install -j$(nproc) pdo_mysql mysql mysqli iconv mcrypt opcache && \
    yum clean

COPY myapp /var/www/html/
