#!/usr/bin/env bash

for theme_directory in $(find /srv/www/*/public_html/wp-content/themes -maxdepth 1 -type d)

do
    if [ -f  $theme_directory/node_modules.tar.gz ]; then
        rm -rf theme_directory/node_modules/*

        tar -xzhf $theme_directory/node_modules.tar.gz\
            -C $theme_directory
    fi
done
