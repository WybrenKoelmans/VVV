#!/usr/bin/env bash

cd /vagrant/www/wordpress-homedeal/htdocs/

plugins=(
    advanced-code-editor
    advanced-custom-fields
    akismet
    better-wordpress-showhide-elements
    disqus-comment-system
    orbisius-child-theme-creator
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
if ! wp plugin is-installed $plugin; then
	wp plugin install $plugin --activate
fi
done

echo 'Updating Plugins'
wp plugin update --all
