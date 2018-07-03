#!/bin/bash
#web环境部署

#############################Php
docker build -t php:7.2.7-fpm-rewrite ./php 

docker pull php:7.2.7-fpm-rewrite
docker rm $(docker ps -a| grep "php" |cut -d " " -f 1) -f
docker run -d --name php --net=host  \
	-v /usr/local/docker/php/www:/www \
	-v /usr/local/docker/php/conf/php.ini:/usr/local/etc/php/php.ini \
	-v /usr/local/docker/php/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf \
	-v /usr/local/docker/php/conf/php-fpm.d/www.conf:/usr/local/etc/php-fpm.d/www.conf \
	-v /usr/local/docker/php/logs:/phplogs \
	php:7.2.7-fpm-rewrite
 
############################Nginx
 
docker pull nginx
docker rm $(docker ps -a| grep "nginx" |cut -d " " -f 1) -f
docker run -d --name nginx --net=host \
	-v /usr/local/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
	-v /usr/local/docker/nginx/conf/conf.d:/etc/nginx/conf.d \
	-v /usr/local/docker/nginx/logs:/var/log/nginx \
	-v /usr/local/docker/nginx/html:/var/www/html \
	nginx
