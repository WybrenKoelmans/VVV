#!/usr/bin/env bash

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Create public dir if it doesn't exist yet
mkdir -p ${VVV_PATH_TO_SITE}/public_html

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-homedeal\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-homedeal\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

if [[ ! -f "${VVV_PATH_TO_SITE}/public_html/wp-load.php" ]]; then
    ( exec "/srv/provision/wordpress-homedeal/install-wordpress.sh" )
    ( exec "/srv/provision/wordpress-homedeal/import-db.sh" )
    ( exec "/srv/provision/wordpress-homedeal/import-plugins.sh" )
    ( exec "/srv/provision/wordpress-homedeal/import-uploads.sh" )
fi
