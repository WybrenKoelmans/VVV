#!/usr/bin/env bash

cd /vagrant/www/wordpress-homedeal/

plugins=(
    advanced-custom-fields
    better-wordpress-showhide-elements
    raw-html
    tablepress
    tinymce-advanced
    wordpress-faq-manager
    wordpress-importer
    wordpress-seo
    wp-mail-smtp
)

echo 'Install required plugins'

for plugin in "${plugins[@]}"
do
if ! wp plugin is-installed $plugin --allow-root; then
	wp plugin install $plugin --allow-root --activate-network
fi
done

echo 'Updating Plugins'
wp plugin update --allow-root --all
