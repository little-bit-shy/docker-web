FROM php:7.2.7-fpm

RUN apt-get update && apt-get install -y \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        openssl \
        libssl-dev \
        unzip \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install redis-4.0.1 \
    && docker-php-ext-enable redis
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install opcache

RUN cd /tmp \
    && wget http://pecl.php.net/get/swoole-4.2.6.tgz \
    && tar -xzf /tmp/swoole-4.2.6.tgz -C /usr/src/swoole --strip-components=1 \
    && cd /usr/src/swoole \
    && phpize \
    && ./configure --enable-openssl \
    && make \
    && make install \
    && docker-php-ext-enable swoole \
    && rm -f /tmp/swoole-4.2.6.tgz \
    && rm -r /usr/src/swoole

RUN cd /tmp \
    && wget https://github.com/edenhill/librdkafka/archive/v1.0.0.zip -O librdkafka.zip \
    && unzip librdkafka.zip \
    && cd librdkafka-1.0.0 \
    && ./configure \
    && make \
    && make install \
    && rm -f /tmp/librdkafka.zip

RUN pecl install rdkafka \
    && docker-php-ext-enable rdkafka

WORKDIR /www


