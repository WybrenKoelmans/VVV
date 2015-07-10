#!/usr/bin/env bash

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-skydreams\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-skydreams\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

cd /vagrant/www/wordpress-skydreams/

if [ ! -d "htdocs" ]; then
	echo 'Installing WordPress (release version) in wordpress-skydreams/htdocs...'
	mkdir ./htdocs
cd ./htdocs
	cd /vagrant/www/wordpress-skydreams/

	wp core download --allow-root
	wp core config --dbname="wordpress-skydreams" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --extra-php <<PHP
define('WP_DEBUG', true );
define('WP_DEBUG_LOG', true );
define('PARTNER_URL', 'http://partners.skydreams.com.dev');
define('SKYAPI_URL', 'http://skyapi.net.dev');
define('ALLOW_UNFILTERED_UPLOADS', true );

/* Multisite */
define('WP_ALLOW_MULTISITE', true );
define('MULTISITE', true);
define('SUBDOMAIN_INSTALL', false);
define('DOMAIN_CURRENT_SITE', 'wordpress.skydreams.com.dev');
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 1);

define( 'SUNRISE', 'on' );
PHP

	echo 'Copy sunrise.php to correct location and adjust our wp-config to support domain mapping'
	cp /vagrant/www/wordpress-skydreams/sunrise.php /vagrant/www/wordpress-skydreams/htdocs/wp-content/sunrise.php
fi

if ! $(wp core is-installed --network); then
	( exec "/vagrant/scripts/wordpress-skydreams/import-db.sh" )
fi

if $(wp core is-installed --network); then
	( exec "/vagrant/scripts/wordpress-skydreams/update-plugins.sh" )
fi

cd -
