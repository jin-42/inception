#!/bin/bash

echo "🚀 Configuration de WordPress..."

# Attendre que MariaDB soit prête
echo "⏳ Attente de la base de données..."
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    echo "Attente de MariaDB..."
    sleep 2
done
echo "✅ Base de données prête !"

# Aller dans le répertoire WordPress
cd /var/www/html

# Télécharger WordPress si pas déjà fait
if [ ! -f wp-config.php ]; then
    echo "📥 Téléchargement de WordPress..."
    
    # Télécharger WordPress
    wp core download --allow-root
    
    # Créer wp-config.php
    echo "⚙️ Configuration de WordPress..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
    
    # Installer WordPress
    echo "🔧 Installation de WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="Mon Site Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    # Créer un utilisateur supplémentaire (requis par le sujet)
    echo "👤 Création d'un utilisateur supplémentaire..."
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
    
    echo "✅ WordPress installé avec succès !"
fi

# Ajuster les permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "🏁 Démarrage de PHP-FPM..."

# Démarrer PHP-FPM en mode foreground
exec php-fpm7.4 --nodaemonize