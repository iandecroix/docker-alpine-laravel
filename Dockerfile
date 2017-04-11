FROM php:7-fpm-alpine
MAINTAINER Niels van Doorn <n.van.doorn@outlook.com>

RUN apk --update add wget \
  curl \
  git \
  grep \
  nginx \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  zlib-dev \
  supervisor

RUN docker-php-ext-install mysqli mbstring pdo mcrypt pdo tokenizer xml
RUN pecl install memcached

RUN apk --update add

RUN rm /var/cache/apk/* && \
    mkdir -p /var/www

COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]