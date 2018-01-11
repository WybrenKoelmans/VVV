#!/usr/bin/env bash

cd /vagrant/www/wordpress-homedeal/htdocs

wp core download --allow-root
wp core config --dbname="wordpress-homedeal" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root --extra-php <<PHP
define('WP_DEBUG', true );
define('WP_DEBUG_LOG', true );
define('PARTNER_URL', 'http://partners.skydreams.com.dev.skydreams.com');
define('SKYAPI_URL', 'http://skyapi.net.dev.skydreams.com');
define('ALLOW_UNFILTERED_UPLOADS', true );

define('WP_ALLOW_MULTISITE', true );
define('MULTISITE', true);
define('SUBDOMAIN_INSTALL', false);
define('DOMAIN_CURRENT_SITE', 'homedeal.com.dev.skydreams.com');
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 1);
PHP
