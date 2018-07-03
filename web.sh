#!/bin/bash
#web环境部署

dir="/usr/local/docker"
[ -d "$dir" ] && rm -rf "$dir"
mkdir "$dir"
mv ./php ${dir}
mv ./nginx ${dir}

#############################Php
docker build -t php:7.2.7-fpm-rewrite ${dir}/php

docker pull php:7.2.7-fpm-rewrite
docker rm $(docker ps -a| grep "php" |cut -d " " -f 1) -f
docker run -d --name php --net=host  \
	-v ${dir}/php/www:/www \
	-v ${dir}/php/conf/php.ini:/usr/local/etc/php/php.ini \
	-v ${dir}/php/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf \
	-v ${dir}/php/conf/php-fpm.d/www.conf:/usr/local/etc/php-fpm.d/www.conf \
	-v ${dir}/php/logs:/phplogs \
	php:7.2.7-fpm-rewrite
 
############################Nginx
 
docker pull nginx
docker rm $(docker ps -a| grep "nginx" |cut -d " " -f 1) -f
docker run -d --name nginx --net=host \
	-v ${dir}/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
	-v ${dir}/nginx/conf/conf.d:/etc/nginx/conf.d \
	-v ${dir}/nginx/logs:/var/log/nginx \
	-v ${dir}/nginx/html:/var/www/html \
	nginx
