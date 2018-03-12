FROM php:7.2.3-fpm-alpine3.7
MAINTAINER Liang Lei <square0083@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add autoconf make g++ yaml-dev zlib-dev libmemcached-dev curl tzdata libpng-dev && docker-php-ext-intall gd pdo pdo_mysql bcmath

RUN pecl install yaml redis mongodb xdebug memcached msgpack

EXPOSE "9000"
