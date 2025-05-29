#!/bin/bash

echo "🚀 Démarrage de MariaDB pour Inception..."

# 1. Vérifier si MariaDB est déjà initialisée
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "📦 Première installation - Initialisation de MariaDB..."
    
    # Initialiser la base de données
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm --cross-bootstrap
    
    # Créer le fichier temporaire SQL pour la configuration
    cat > /tmp/init.sql << EOF
USE mysql;
FLUSH PRIVILEGES;

-- Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE User='';

-- Configurer le mot de passe root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Créer l'utilisateur root pour les connexions externes
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Supprimer la base test
DROP DATABASE IF EXISTS test;

-- Créer la base de données du projet
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Créer l'utilisateur du projet
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

    echo "⚙️ Configuration initiale de MariaDB..."
    # Lancer MariaDB avec le script d'initialisation
    mysqld --user=mysql --bootstrap --verbose=0 < /tmp/init.sql
    
    # Nettoyer
    rm -f /tmp/init.sql
    
    echo "✅ MariaDB configurée avec succès !"
fi

echo "🏁 Démarrage final de MariaDB..."
# Démarrer MariaDB normalement
exec mysqld --user=mysql --console