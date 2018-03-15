FROM php:7.2.3-fpm-alpine3.7
MAINTAINER Liang Lei <square0083@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache autoconf make g++ yaml-dev zlib-dev libmemcached-dev curl tzdata libpng-dev gearman-dev@testing && docker-php-ext-install gd pdo pdo_mysql bcmath \

    # add third package
    && pecl install yaml redis mongodb xdebug memcached msgpack \

    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \

    # add gearman
    && cd /tmp && wget -c 'https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.zip' \
    && unzip gearman-2.0.3.zip && cd pecl-gearman-gearman-2.0.3 && phpize && ./configure && make && make install \

    # add php common extensions
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini \
    && echo "extension=memcached.so" >> /usr/local/etc/php/conf.d/memcached.ini \
    && echo "extension=msgpack.so" >> /usr/local/etc/php/conf.d/msgpack.ini \
    && echo "extension=gearman.so" >> /usr/local/etc/php/conf.d/gearman.ini

EXPOSE "9000"
