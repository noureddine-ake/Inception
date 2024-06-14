# pull base image
FROM debian:bullseye

RUN apt-get update

RUN apt-get install -y \
    php php7.4-fpm php-mysql \
    mariadb-client wget curl \
    php-redis \
    iputils-ping

COPY ./conf/auto_config.sh auto_config.sh

RUN chmod +x auto_config.sh

ENTRYPOINT ["./auto_config.sh"]
