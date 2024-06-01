FROM debian:bullseye
COPY ./tools/install.sh .
RUN chmod +x install.sh && ./install.sh
COPY ./conf/nginx.conf /etc/nginx/sites-available/default
CMD ["nginx", "-g", "daemon off;"]
