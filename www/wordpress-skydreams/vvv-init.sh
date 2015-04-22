#!/usr/bin/env bash

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-skydreams\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-skydreams\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

cd /vagrant/www/wordpress-skydreams/

if [ ! -d "htdocs" ]; then
	echo 'Installing WordPress (release version) in wordpress-skydreams/htdocs...'
	mkdir ./htdocs
cd ./htdocs
	source /vagrant/scripts/wordpress-skydreams/import-db.sh;

	cd /vagrant/www/wordpress-skydreams/

	wp core download --allow-root
	wp core config --dbname="wordpress-skydreams" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root --extra-php <<PHP
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

	echo 'Add skydev user'
	wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
	wp super-admin add test@skydreams.com
fi

cd /vagrant/www/wordpress-skydreams/htdocs

for url in $(wp site list --field=url)
do
	wp core update-db --url=$url

	# Update disqus_form_url as we don't want to affect comments @ production
	wp option update disqus_forum_url skydreams-test --url=$url

	# Add skydev user to each site
	wp user set-role skydev administrator --url=$url

	# Change all themes to weetjes, because child themes arent' available in our repo
	wp option update stylesheet weetjes --url=$url
done

wp db query "DELETE FROM wp_domain_mapping WHERE wp_domain_mapping.active = 0;" --path='/vagrant/www/wordpress-skydreams/htdocs/'
wp db query "UPDATE wp_domain_mapping SET wp_domain_mapping.domain = CONCAT( RIGHT ( wp_domain_mapping.domain, (LENGTH(wp_domain_mapping.domain) - 4) ), '.dev') WHERE wp_domain_mapping.domain NOT LIKE '%.dev';" --path='/vagrant/www/wordpress-skydreams/htdocs/'

source /vagrant/scripts/wordpress-skydreams/update-plugins.sh;
cd -
