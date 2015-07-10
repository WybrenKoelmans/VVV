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
	wp core config --dbname="wordpress-homedeal" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root --extra-php <<PHP
define('WP_DEBUG', true );
define('WP_DEBUG_LOG', true );
define('PARTNER_URL', 'http://partners.skydreams.com.dev');
define('SKYAPI_URL', 'http://skyapi.net.dev');
define('ALLOW_UNFILTERED_UPLOADS', true );

define('WP_ALLOW_MULTISITE', true );
define('MULTISITE', true);
define('SUBDOMAIN_INSTALL', false);
define('DOMAIN_CURRENT_SITE', 'homedeal.nl.dev');
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 1);

PHP
fi

if ! $(wp core is-installed --network); then
	( exec "/vagrant/scripts/wordpress-homedeal/import-db.sh" )
	( exec "/vagrant/scripts/wordpress-homedeal/install-blog-theme.sh" )
fi

if $(wp core is-installed --network); then
	( exec "/vagrant/scripts/wordpress-homedeal/update-plugins.sh" )
fi
