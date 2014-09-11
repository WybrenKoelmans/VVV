echo "Import latest live db backup"
gzip -dc /vagrant/wordpress.sql.gz | mysql --user=root --password=root wordpress-skydreams

php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s https://wordpress.skydreams.com -r http://wordpress.skydreams.com
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev

echo "Add skydev user"
cd /vagrant/www/wordpress-skydreams/htdocs/
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
wp super-admin add test@skydreams.com