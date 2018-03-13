FROM php:7.2.3-fpm-alpine3.7
MAINTAINER Liang Lei <square0083@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add autoconf make g++ yaml-dev zlib-dev libmemcached-dev curl tzdata libpng-dev && docker-php-ext-install gd pdo pdo_mysql bcmath \
    && pecl install yaml redis mongodb xdebug memcached msgpack \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini \
    && echo "extension=memcached.so" >> /usr/local/etc/php/conf.d/memcached.ini \
    && echo "extension=msgpack.so" >> /usr/local/etc/php/conf.d/msgpack.ini

EXPOSE "9000"
