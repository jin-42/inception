FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl \
    php7.4-mbstring php7.4-soap php7.4-xml php7.4-zip \
    wget curl mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/wp-cli/v2.8.1/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

