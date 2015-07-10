#!/usr/bin/env bash

if [ ! -f /vagrant/wordpress_homedeal.sql.gz ]; then
    echo "wordpress_homedeal.sql.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

echo "Importing latest live db backup..."
gzip -dc /vagrant/wordpress_homedeal.sql.gz | mysql --user=root --password=root wordpress-homedeal

echo "Start db string replacement #1: replace https://www.homedeal.nl -> http://homedeal.nl"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-homedeal -p skydev -s https://www.homedeal.nl -r http://homedeal.nl -v false

echo "Start db string replacement #2: replace www.homedeal.nl -> homedeal.nl"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-homedeal -p skydev -s www.homedeal.nl -r homedeal.nl -v false

echo "Start db string replacement #3: replace https://blog.homedeal.nl -> http://blog.homedeal.nl"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-homedeal -p skydev -s https://blog.homedeal.nl -r http://blog.homedeal.nl -v false

echo "Start db string replacement #4: replace homedeal.nl -> homedeal.nl.dev"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-homedeal -p skydev -s homedeal.nl -r homedeal.nl.dev -v false

cd /vagrant/www/wordpress-homedeal/htdocs

echo 'Add skydev user'
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator --allow-root
wp super-admin add test@skydreams.com --allow-root

wp core update-db --allow-root

for url in $(wp site list --allow-root --field=url)
do
	wp core update-db --url=$url --allow-root

	# Add skydev user to each site
	wp user set-role skydev administrator --url=$url --allow-root
done
