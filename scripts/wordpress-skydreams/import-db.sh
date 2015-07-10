#!/usr/bin/env bash

if [ ! -f /vagrant/wordpress_weetjes.sql.gz ]; then
    echo "wordpress_weetjes.sql.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

echo "Importing latest live db backup..."
gzip -dc /vagrant/wordpress_weetjes.sql.gz | mysql --user=root --password=root wordpress-skydreams

echo "Start db string replacement #1: replace https://wordpress.skydreams.com -> http://wordpress.skydreams.com"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s https://wordpress.skydreams.com -r http://wordpress.skydreams.com -v false

echo "Start db string replacement #2: replace wordpress.skydreams.com -> wordpress.skydreams.com.dev"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev -v false

cd /vagrant/www/wordpress-skydreams/htdocs

echo 'Add skydev user'
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator --allow-root
wp super-admin add test@skydreams.com --allow-root

for url in $(wp site list --allow-root --field=url)
do
	wp core update-db --url=$url --allow-root

	# Update disqus_form_url as we don't want to affect comments @ production
	wp option update disqus_forum_url skydreams-test --url=$url --allow-root

	# Add skydev user to each site
	wp user set-role skydev administrator --url=$url --allow-root

	# Change all themes to weetjes, because child themes arent' available in our repo
	wp option update stylesheet weetjes --url=$url --allow-root
done

wp db query "DELETE FROM wp_domain_mapping WHERE wp_domain_mapping.active = 0;" --path='/vagrant/www/wordpress-skydreams/htdocs/' --allow-root
wp db query "UPDATE wp_domain_mapping SET wp_domain_mapping.domain = CONCAT( RIGHT ( wp_domain_mapping.domain, (LENGTH(wp_domain_mapping.domain) - 4) ), '.dev') WHERE wp_domain_mapping.domain NOT LIKE '%.dev';" --path='/vagrant/www/wordpress-skydreams/htdocs/' --allow-root
