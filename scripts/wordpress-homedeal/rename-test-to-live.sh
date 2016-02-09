#!/usr/bin/env bash

cd /var/www/app/default/wordpress

old_url='test-wordpress.skydreams.com'
new_blog_url='wordpress.skydreams.com'
new_protocol='http://'
sites=( "wordpress.skydreams.com/tegelzetter/" "wordpress.skydreams.com/dubbelglas/" "wordpress.skydreams.com/stucadoor/" )


cd /var/www/app/homedeal/

for url in "${sites[@]}"
do

wp search-replace --url=$url http://$old_url $new_protocol$new_blog_url --dry-run
wp search-replace --url=$url https://$old_url $new_protocol$new_blog_url --dry-run
wp search-replace --url=$url $old_url $new_blog_url --dry-run

done
