FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y redis-server

RUN sed -i 's/^bind 127.0.0.1 ::1/# bind 0.0.0.0 ::1/' /etc/redis/redis.conf
RUN sed -i 's/^daemonize yes/daemonize no/' /etc/redis/redis.conf
RUN echo 'protected-mode no' >> /etc/redis/redis.conf

CMD [ "redis-server", "/etc/redis/redis.conf"]