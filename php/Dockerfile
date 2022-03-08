FROM php:7.4-fpm

ENV TZ='Asia/Shanghai'

RUN rm -rf /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ buster main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ buster main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list

RUN apt-get update

RUN pecl install redis-5.3.4 && docker-php-ext-enable redis
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install opcache

RUN apt-get install libssl1.1=1.1.1d-0+deb10u7 -y --allow-downgrades
RUN apt-get install zlib1g=1:1.2.11.dfsg-1 -y --allow-downgrades
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libssl-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

WORKDIR /www

RUN apt-get install -y wget unzip

# swoole扩展
RUN cd /tmp \
    && mkdir /usr/src/swoole \
    && wget http://pecl.php.net/get/swoole-4.7.1.tgz \
    && tar -xzf /tmp/swoole-4.7.1.tgz -C /usr/src/swoole --strip-components=1 \
    && cd /usr/src/swoole \
    && phpize \
    && ./configure --enable-openssl \
    && make \
    && make install \
    && docker-php-ext-enable swoole \
    && rm -f /tmp/swoole-4.7.1.tgz \
    && rm -r /usr/src/swoole

# kafka扩展
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
    
# php-amqplib依赖，用于rabbitmq
RUN docker-php-ext-install bcmath
    

