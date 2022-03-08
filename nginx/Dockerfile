FROM openresty/openresty:1.19.9.1-5-centos7

ENV TZ='Asia/Shanghai'

RUN yum install -y logrotate crontabs
RUN crond
RUN echo "0 3 * * * /usr/sbin/logrotate -f /etc/logrotate.d/openresty > /dev/null 2>&1" >> /var/spool/cron/root

WORKDIR /usr/local/openresty/nginx/html
