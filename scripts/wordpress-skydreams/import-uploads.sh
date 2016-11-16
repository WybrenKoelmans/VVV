#!/usr/bin/env bash

echo "Import Weetjes Uploads"

if [ ! -f /vagrant/wordpress_uploads.tar.gz ]; then
    echo "wordpress_uploads.tar.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

rm -rf /vagrant/www/wordpress-skydreams/htdocs/wp-content/uploads/*
tar -xzhf /vagrant/wordpress_uploads.tar.gz \
    -C /vagrant/www/wordpress-skydreams/htdocs/wp-content
