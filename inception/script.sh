# Ajouter le domaine au hosts
echo "127.0.0.1 fsulvac.42.fr" | sudo tee -a /etc/hosts

# Aller dans le dossier créé
cd inception

# Lancer le projet
make
