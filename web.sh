#!/bin/bash
#web环境部署

#############################Php
docker build -t php:7.2.7-fpm-rewrite ./php 

docker pull php:7.2.7-fpm-rewrite
docker rm $(docker ps -a| grep "php" |cut -d " " -f 1) -f
docker run -d --name php --net=host  \
	-v ./php/www:/www \
	-v ./php/conf/php.ini:/usr/local/etc/php/php.ini \
	-v ./php/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf \
	-v ./php/conf/php-fpm.d/www.conf:/usr/local/etc/php-fpm.d/www.conf \
	-v ./php/logs:/phplogs \
	php:7.2.7-fpm-rewrite
 
############################Nginx
 
docker pull nginx
docker rm $(docker ps -a| grep "nginx" |cut -d " " -f 1) -f
docker run -d --name nginx --net=host \
	-v ./nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
	-v ./nginx/conf/conf.d:/etc/nginx/conf.d \
	-v ./nginx/logs:/var/log/nginx \
	-v ./nginx/html:/var/www/html \
	nginx
