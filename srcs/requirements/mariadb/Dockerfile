FROM debian:bullseye

RUN (apt-get update > /dev/null)&& \
    (apt-get install -y mariadb-server > /dev/null)

COPY ./tools/init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

CMD [ "/tmp/init.sh" ]
