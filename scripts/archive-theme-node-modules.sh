#!/usr/bin/env bash

for theme_directory in $(find /vagrant/www/*/htdocs/wp-content/themes -maxdepth 1 -type d)
do
    if [ -d  $theme_directory/node_modules ]; then

        echo "$theme_directory"

        tar -czf $theme_directory/node_modules.tar.gz \
            -C $theme_directory \
            node_modules
    fi
done

