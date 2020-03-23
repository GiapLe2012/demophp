FROM php:7.2-apache

RUN apt-get update && \
    apt-get clean

COPY myapp /var/www/html/
