FROM debian:bullseye
COPY requirements/nginx/tools/install.sh .
RUN chmod +x install.sh && ./install.sh && mkdir /var/www/static-website && \
    chmod 777 /var/www/static-website && chown -R www-data:www-data /var/www/static-website
COPY requirements/bonus/static-website/index.html /var/www/static-website/index.html
COPY requirements/bonus/static-website/style.css /var/www/static-website/style.css

COPY requirements/bonus/static-website/script.js /var/www/static-website/script.js
COPY requirements/nginx/conf/nginx.conf /etc/nginx/sites-available/default
CMD ["nginx", "-g", "daemon off;"]
