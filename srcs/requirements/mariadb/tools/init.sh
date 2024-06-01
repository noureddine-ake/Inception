#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

echo -e "${YELLOW}[CONFIGURING MARIADB DATABASE....]${RESET}"

service mariadb start > /dev/null 2>&1
sleep 6

mysql -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" > /dev/null 2>&1
mysql -e "CREATE USER IF NOT EXISTS $SQL_USER@'%' IDENTIFIED BY '$SQL_PASSWORD';" > /dev/null 2>&1
mysql -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'%';" > /dev/null 2>&1
mysql -e "FLUSH PRIVILEGES;" > /dev/null 2>&1

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown > /dev/null 2>&1

echo -e "${GREEN}[MARIADB DATABASE CONFIGURATION COMPLETED ✅]${RESET}"

echo -e "${YELLOW}[STARTING MARIADB SERVER.....]${RESET}"

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql' > /dev/null 2>&1
