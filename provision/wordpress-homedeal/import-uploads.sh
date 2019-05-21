#!/usr/bin/env bash

echo "Import HomeDeal Uploads (this might take a while)"

if [ ! -f /srv/database/imports/wordpress_homedeal_uploads.tar.gz ]; then
    echo "wordpress_homedeal_uploads.tar.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

rm -rf /srv/www/wordpress-homedeal/public_html/wp-content/uploads/*
tar -xzhf /srv/database/imports/wordpress_homedeal_uploads.tar.gz \
    -C /srv/www/wordpress-homedeal/public_html/wp-content
