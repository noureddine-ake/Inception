FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd

# COPY /conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/add_ftp_user.sh /usr/local/bin/

# RUN chmod +x /tmp/add_ftp_user.sh && /tmp/add_ftp_user.sh && rm /tmp/add_ftp_user.sh
# EXPOSE 21

CMD ["bash", "/usr/local/bin/add_ftp_user.sh"]
