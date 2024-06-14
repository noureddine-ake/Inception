FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd

COPY ./tools/add_ftp_user.sh /usr/local/bin/

CMD ["bash", "/usr/local/bin/add_ftp_user.sh"]
