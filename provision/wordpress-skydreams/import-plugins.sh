#!/usr/bin/env bash

echo "Import Weetjes Plugins"

if [ ! -f /srv/database/imports/wordpress_plugins.tar.gz ]; then
    echo "wordpress_plugins.tar.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

rm -rf /srv/www/wordpress-skydreams/public_html/wp-content/plugins/*
tar -xzhf /srv/database/imports/wordpress_plugins.tar.gz \
    -C /srv/www/wordpress-skydreams/public_html/wp-content


