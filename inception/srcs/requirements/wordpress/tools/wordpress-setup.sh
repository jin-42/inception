#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h mariadb -u ${WORDPRESS_DB_USER} -p${WORDPRESS_DB_PASSWORD} --silent; do
    sleep 1
done

echo "MariaDB is ready!"

# Download WordPress if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
    
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_USER} \
        --dbpass=${WORDPRESS_DB_PASSWORD} \
        --dbhost=${WORDPRESS_DB_HOST} \
        --allow-root
    
    echo "Installing WordPress..."
    wp core install \
        --url=${WORDPRESS_URL} \
        --title="${WORDPRESS_TITLE}" \
        --admin_user=${WORDPRESS_ADMIN_USER} \
        --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
        --admin_email=${WORDPRESS_ADMIN_EMAIL} \
        --allow-root
    
    echo "Creating additional user..."
    wp user create \
        ${WORDPRESS_USER} \
        ${WORDPRESS_USER_EMAIL} \
        --user_pass=${WORDPRESS_USER_PASSWORD} \
        --role=author \
        --allow-root
        
    echo "WordPress setup complete!"
fi

# Change ownership
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7.4 -F
