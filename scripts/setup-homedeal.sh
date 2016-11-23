#!/usr/bin/env bash

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-homedeal\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-homedeal\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

cd /vagrant/www/wordpress-homedeal/

if [ ! -f "htdocs/wp-config.php" ]; then
	echo 'Installing WordPress (release version) in wordpress-homedeal/htdocs...'
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
define('DOMAIN_CURRENT_SITE', 'homedeal.com.dev');
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 1);

define( 'SUNRISE', 'on' );
PHP
	echo 'Copy sunrise.php to correct location and adjust our wp-config to support domain mapping'
	cp /vagrant/www/wordpress-homedeal/sunrise.php /vagrant/www/wordpress-homedeal/htdocs/wp-content/sunrise.php
fi

if ! $(wp core is-installed --network --allow-root); then
	( exec "/vagrant/scripts/wordpress-homedeal/import-db.sh" )
    ( exec "/vagrant/scripts/wordpress-homedeal/import-plugins.sh" )
    ( exec "/vagrant/scripts/wordpress-homedeal/import-uploads.sh" )
	( exec "/vagrant/scripts/wordpress-homedeal/install-blog-theme.sh" )
fi
