FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/v2.6.0/utils/wp-cli-installer.php && \
    php wp-cli-installer.php && \
    rm wp-cli-installer.php && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create WordPress directory
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# Copy WordPress setup script
COPY tools/wordpress-setup.sh /usr/local/bin/wordpress-setup.sh
RUN chmod +x /usr/local/bin/wordpress-setup.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/local/bin/wordpress-setup.sh"]
