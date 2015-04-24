#!/usr/bin/env bash

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-homedeal\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-homedeal\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

cd /vagrant/www/wordpress-homedeal/

if [ ! -d "htdocs" ]; then
	echo 'Installing WordPress (release version) in wordpress-homedeal/htdocs...'
	mkdir ./htdocs
cd ./htdocs
	cd /vagrant/www/wordpress-homedeal/
	wp core download --allow-root
	wp core install --url="homedeal.nl.dev" --title="HomeDeal" --admin_user="skydev" --admin_password="skydev" --admin_email="test@skydreams.com"
	wp core config --dbname="wordpress-homedeal" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root --extra-php <<PHP
define('WP_DEBUG', true );
define('WP_DEBUG_LOG', true );
define('PARTNER_URL', 'http://partners.skydreams.com.dev');
define('SKYAPI_URL', 'http://skyapi.net.dev');
define('ALLOW_UNFILTERED_UPLOADS', true );
PHP

	echo 'Add skydev user'
	wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
fi

cd /vagrant/www/wordpress-homedeal/htdocs

wp core update-db

source /vagrant/scripts/wordpress-homedeal/update-plugins.sh;
