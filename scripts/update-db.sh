echo "Import latest live db backup"
gzip -dc /vagrant/wordpress.sql.gz | mysql --user=root --password=root wordpress-skydreams

echo "Truncate domain mapping table"
mysql --user=skydev --password=skydev wordpress-skydreams -e 'TRUNCATE wp_domain_mapping;'

echo "Replace live domain with dev domain"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s https://wordpress.skydreams.com -r http://wordpress.skydreams.com
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev

cd /vagrant/www/wordpress-skydreams/htdocs/

echo "Add skydev user"
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
wp super-admin add test@skydreams.com

for url in $(wp site list --field=url)
do
	wp option update disqus_forum_url skydreams-test --url=$url
	wp user set-role skydev administrator --url=$url
done
