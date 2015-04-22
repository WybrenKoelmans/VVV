#!/usr/bin/env bash
echo "Importing latest live db backup..."
gzip -dc /vagrant/wordpress.sql.gz | mysql --user=root --password=root wordpress-skydreams

echo "Start db string replacement #1: replace https://wordpress.skydreams.com -> http://wordpress.skydreams.com"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s https://wordpress.skydreams.com -r http://wordpress.skydreams.com -v false

echo "Start db string replacement #2: replace wordpress.skydreams.com -> wordpress.skydreams.com.dev"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev -v false
