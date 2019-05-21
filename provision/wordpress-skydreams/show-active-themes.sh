#!/usr/bin/env bash

# Dumps a list of themes that are used within our network
cd /srv/www/wordpress-skydreams/public_html/

for url in $(wp site list --field=url)
do
    echo "$(echo $url)" "$(echo " - ")" "$(wp theme list --status=active --field=name --url=$url)"
done

