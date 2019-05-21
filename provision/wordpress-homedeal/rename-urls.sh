#!/usr/bin/env bash

cd /var/www/app/default/test/homedeal/
echo "rsync wordpress homedeal files from live to test..."
rsync -a --delete --exclude=wp-config.php . ../../../app/homedeal/

old_homedeal_url='test-homedeal.skydreams.com'
new_blog_url='homedeal.nl'
new_protocol='https://'

mysql -u wp_homedeal --password=GQq1M5w35xf066C wordpress_homedeal -e "UPDATE wp_blogs SET wp_blogs.domain = REPLACE(wp_blogs.domain, '$old_homedeal_url', '$new_blog_url') WHERE wp_blogs.domain LIKE '%$old_homedeal_url%';"

cd /var/www/app/homedeal/

for url in $(wp site list --field=url)
do

wp search-replace --url=$url http://$old_homedeal_url $new_protocol$new_blog_url
wp search-replace --url=$url https://$old_homedeal_url $new_protocol$new_blog_url
wp search-replace --url=$url $old_homedeal_url $new_blog_url

done
