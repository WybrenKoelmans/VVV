#!/usr/bin/env bash

# Dumps a list of themes that are used within our network
cd /vagrant/www/wordpress-skydreams/htdocs/

for url in $(wp site list --field=url)
do
    echo "$(echo $url)" "$(echo " - ")" "$(wp theme list --status=active --field=name --url=$url)"
done

