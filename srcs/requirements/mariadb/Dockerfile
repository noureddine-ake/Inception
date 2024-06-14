FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server 

COPY ./tools/init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

CMD [ "/tmp/init.sh" ]
