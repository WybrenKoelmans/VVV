#!/usr/bin/env bash

if [ ! -f /vagrant/wordpress-dev.sql.gz ]; then
    echo "wordpress-dev.sql.gz can't be found. Please add this file to the root directory and run this again!"
    exit 0
fi

echo "Importing dev db..."
gzip -dc /vagrant/wordpress-dev.sql.gz | mysql --user=root --password=root wordpress-skydreams
