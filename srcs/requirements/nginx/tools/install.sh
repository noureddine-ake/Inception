#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"


echo -e "${YELLOW}[INSTALLING NGINX WEBSERVER AND GENERATING SSL CERTIFICATE....]${RESET}"
apt-get update > /dev/null 2>&1
apt-get install -y nginx openssl > /dev/null 2>&1

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=Béni Mellal-Khénifra/L=Khouribga/O=1337/CN=nakebli.42.fr" > /dev/null 2>&1

echo -e "${GREEN}[NGINX WEBSERVER INSTALLATION AND SSL CERTIFICATE GENERATION COMPLETED ✅]${RESET}"
