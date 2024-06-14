#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

sleep 5
cd /var/www || (echo "${RED}Can't find /var/www. Exiting... ${RESET}" && exit 1)

if [ -d "wordpress" ]; then
    echo -e "${YELLOW}Warning: WordPress files seem to already be present here. Skipping download and extraction. ${RESET}"
else
    echo -e "${YELLOW}[downloading WordPress...] ${RESET}"
    wget https://fr.wordpress.org/latest-fr_FR.tar.gz
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to download WordPress archive. Exiting...${RESET}"
        exit 1
    fi
    tar -xvzf latest-fr_FR.tar.gz
    rm latest-fr_FR.tar.gz
    echo -e "${GREEN}[WordPress download completed ✅] ${RESET}"
fi

PHP_VERSION="7.4"
NEW_LISTEN="wordpress:9000"
PHP_FPM_CONF="/etc/php/$PHP_VERSION/fpm/pool.d/www.conf"
SERVICE_NAME="php$PHP_VERSION-fpm"

if [ ! -f "$PHP_FPM_CONF" ]; then
    echo -e "${RED}PHP-FPM configuration file not found: $PHP_FPM_CONF. Exiting...${RESET}"
    exit 1
fi

sed -i "s|^listen =.*|listen = $NEW_LISTEN|" "$PHP_FPM_CONF"

mkdir -p /run/php/
chown -R www-data:www-data /run/php/

chown -R www-data:www-data /var/www/wordpress
chmod -R 777 /var/www/wordpress

echo -e "${GREEN}[PHP-FPM configuration updated ✅] ${RESET}"

if [ ! -f "/usr/local/bin/wp" ]; then
    echo -e "${YELLOW}Installing WP-CLI...${RESET}"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    echo -e "${GREEN}WP-CLI installation completed ✅ ${RESET}"
else
    echo -e "${YELLOW}WP-CLI already installed. Skipping...${RESET}"
fi

while true; do
    ping -c 1 mariadb || {
        echo "${YELLOW}[========WAITING FOR MARIADB TO START...========]${RESET}"
        sleep 1
    }
    ping -c 1 mariadb && {
        echo "${GREEN}[========MARIADB IS UP AND RUNNING========]${RESET}"
        break
    }
done

if ! wp core is-installed --allow-root --path=/var/www/wordpress; then
    echo -e "${YELLOW}WordPress is not installed. Installing... ${RESET}"
    wp core download --allow-root --path=/var/www/wordpress
    wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOST --allow-root --path=/var/www/wordpress
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/wordpress
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASSWORD" --role="$WP_U_ROLE" --allow-root  --path=/var/www/wordpress  2>&1
    wp plugin install redis-cache --allow-root --path=/var/www/wordpress
    wp plugin activate redis-cache --allow-root --path=/var/www/wordpress
    wp config set WP_REDIS_HOST redis --allow-root --add --path=/var/www/wordpress
    wp config set WP_REDIS_PORT 6379 --allow-root --add --path=/var/www/wordpress 
    wp redis enable --allow-root --path=/var/www/wordpress
    echo -e "${GREEN}WordPress installation completed ✅ ${RESET}"
else
    echo -e "${YELLOW}WordPress is already installed. Skipping... ${RESET}"
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 777 /var/www/wordpress

phpenmo redis

echo -e "${GREEN}Starting PHP-FPM... ${RESET}"
cat<<EOF > cr





y
EOF

adduser --home /var/www/wordpress $FTP_USER --disabled-password < cr
rm cr

chown -R $FTP_USER:$FTP_USER /var/www/wordpress
/usr/sbin/php-fpm7.4 -F
