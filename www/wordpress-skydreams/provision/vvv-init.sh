#!/usr/bin/env bash

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Create public dir if it doesn't exist yet
mkdir -p ${VVV_PATH_TO_SITE}/public_html

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-skydreams\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-skydreams\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

if [[ ! -f "${VVV_PATH_TO_SITE}/public_html/wp-load.php" ]]; then
    ( exec "/srv/provision/wordpress-skydreams/install-wordpress.sh" )
    ( exec "/srv/provision/wordpress-skydreams/import-db.sh" )
    ( exec "/srv/provision/wordpress-skydreams/import-plugins.sh" )
    ( exec "/srv/provision/wordpress-skydreams/import-uploads.sh" )
fi
