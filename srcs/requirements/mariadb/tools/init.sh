#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

echo -e "${YELLOW}[CONFIGURING MARIADB DATABASE....]${RESET}"

service mariadb start
sleep 6

mysql -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS $SQL_USER@'%' IDENTIFIED BY '$SQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

echo -e "${GREEN}[MARIADB DATABASE CONFIGURATION COMPLETED ✅]${RESET}"

echo -e "${YELLOW}[STARTING MARIADB SERVER.....]${RESET}"

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
