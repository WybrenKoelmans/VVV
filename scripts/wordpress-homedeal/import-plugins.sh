#!/usr/bin/env bash

echo "Import HomeDeal Plugins"

if [ ! -f /vagrant/wordpress_homedeal_plugins.tar.gz ]; then
    echo "wordpress_homedeal_plugins.tar.gz can't be found. Please add this file (see docs) and provision again!"
    exit 0
fi

rm -rf /vagrant/www/wordpress-homedeal/htdocs/wp-content/plugins/*
tar -xzhf /vagrant/wordpress_homedeal_plugins.tar.gz \
    -C /vagrant/www/wordpress-homedeal/htdocs/wp-content
