#!/usr/bin/env bash

if [ ! -f /vagrant/wordpress-live.sql.gz ]; then
    echo "wordpress-live.sql.gz can't be found. Please add this file run this script again!"
    exit 0
fi

echo "Importing db..."
gzip -dc /vagrant/wordpress-live.sql.gz | mysql --user=root --password=root wordpress-skydreams

echo "Start db string replacement #2: replace wordpress.skydreams.com -> wordpress.skydreams.com.dev.skydreams.com"
php /vagrant/scripts/search-replace-db/srdb.cli.php -h localhost -u skydev -n wordpress-skydreams -p skydev -s wordpress.skydreams.com -r wordpress.skydreams.com.dev.skydreams.com -v false -t wp_blogs

cd /vagrant/www/wordpress-skydreams/htdocs

wp plugin deactivate redirection --network --allow-root

echo 'Add skydev user'
wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator --allow-root
wp super-admin add test@skydreams.com --allow-root

# Update site specific urls
for blogId in $(wp site list --allow-root --field=blog_id)

do
    domain=$(wp site list --site__in=$blogId --field=domain)

    # Add skydev user to each site
    wp user set-role skydev administrator --url=$domain --allow-root

    devDomain=$domain

    if [[ "$devDomain" == "www."* ]]; then
        devDomain=${devDomain:4}
    fi

    if [[ "$devDomain" != *".dev.skydreams.com" ]]; then
        devDomain="${devDomain}.dev.skydreams.com"
    fi

    devUrl="http://$devDomain"
    url=$(wp option get siteurl --url=$domain)

    if [ $domain != 'wordpress.skydreams.com.dev.skydreams.com' ]
    then
        wp search-replace $domain $devDomain wp_blogs --allow-root --quiet
    fi

    wp search-replace $url $devUrl --url=$devDomain --allow-root --quiet
done

wp plugin activate redirection  --network
wp core update-db --allow-root --network

# Update disqus_form_url as we don't want to affect comments @ production
wp site option update disqus_forum_url skydreams-test --allow-root

mysqldump --user=root --password=root wordpress-skydreams | gzip > vagrant/wordpress-dev.sql.gz
