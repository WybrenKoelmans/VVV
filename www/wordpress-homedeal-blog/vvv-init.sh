#!/usr/bin/env bash

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-homedeal-blog\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-homedeal-blog\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

cd /vagrant/www/wordpress-homedeal-blog/

if [ ! -d "htdocs" ]; then
	echo 'Installing WordPress (release version) in wordpress-homedeal-blog/htdocs...'
	mkdir ./htdocs
cd ./htdocs
	cd /vagrant/www/wordpress-homedeal-blog/
	wp core download --allow-root
	wp core install --url="blog.homedeal.nl.dev" --title="HomeDeal Blog" --admin_user="skydev" --admin_password="skydev" --admin_email="test@skydreams.com"
	wp core config --dbname="wordpress-homedeal-blog" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root --extra-php <<PHP
define('WP_DEBUG', true );
define('WP_DEBUG_LOG', true );
PHP

	echo 'Add skydev user'
	wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
fi

cd /vagrant/www/wordpress-homedeal-blog/htdocs

wp core update-db
