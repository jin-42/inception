#!/bin/bash

if [ -n "$DOMAIN" ]; then 
	mkdir -p /var/www/$DOMAIN
	chown -R www-data:www-data /var/www/$DOMAIN/
	chmod 755 /var/www/$DOMAIN
	echo "/var/www/$DOMAIN has been created !"
else 
	echo "$DOMAIN is empty"
fi

mkdir -p /etc/nginx/ssl
# Génère le certificat auto-signé avec variables d'environnement
openssl req -x509 -nodes -days 365 \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORG}/CN=${DOMAIN}" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert \
    -out /etc/nginx/ssl/cert.crt

echo "Certificat SSL généré avec CN=${DOMAIN}"

# Lance la commande passée au conteneur (ex : nginx)
exec "$@"
