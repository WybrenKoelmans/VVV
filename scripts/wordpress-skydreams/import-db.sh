#!/usr/bin/env bash

if [ ! -f /vagrant/wordpress.sql.gz ]; then
    echo "wordpress.sql.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

echo "Importing latest live db backup..."
gzip -dc /vagrant/wordpress.sql.gz | mysql --user=root --password=root wordpress-skydreams

echo "Start db string replacement #1: replace https://wordpress.skydreams.com -> http://wordpress.skydreams.com"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s https://wordpress.skydreams.com -r http://wordpress.skydreams.com -v false

echo "Start db string replacement #2: replace wordpress.skydreams.com -> wordpress.skydreams.com.dev"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev -v false

cd /vagrant/www/wordpress-skydreams/htdocs

prefix="http://www."
suffix="/"

wp plugin deactivate redirection  --network

# Update site specific urls
for url in $(wp site list --allow-root --field=url)

do
    # Update disqus_form_url as we don't want to affect comments @ production
    wp option update disqus_forum_url skydreams-test --url=$url --allow-root

    # Add skydev user to each site
    wp user set-role skydev administrator --url=$url --allow-root

    if [[ "$url" =~ $mappedDomainDetection ]]; then
        host=${url#$prefix}
        host=${host%$suffix}
        wwwurl="www.$host"
        liveurl="https://www.$host"
        devUrl="$host.dev"
        fullDevUrl="http://$devUrl"

        wp search-replace $wwwurl $devUrl wp_blogs
        wp search-replace $liveurl $fullDevUrl --network
    fi
done

wp plugin activate redirection  --network

echo 'Add skydev user'
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator --allow-root
wp super-admin add test@skydreams.com --allow-root
wp core update-db --allow-root --network
