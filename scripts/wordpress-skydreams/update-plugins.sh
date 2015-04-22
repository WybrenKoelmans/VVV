#!/usr/bin/env bash

cd /vagrant/www/wordpress-skydreams/htdocs/

plugins=(
    advanced-code-editor
    advanced-custom-fields
    akismet
    better-wordpress-showhide-elements
    disqus-comment-system
    orbisius-child-theme-creator
    raw-html
    shareaholic
    tablepress
    tinymce-advanced
    wordpress-faq-manager
    wordpress-importer
    wordpress-mu-domain-mapping
    wordpress-seo
    wp-mail-smtp
    wp-native-dashboard
)

echo 'Install required plugins'

for plugin in "${plugins[@]}"
do
if ! wp plugin is-installed $plugin; then
	wp plugin install $plugin --activate-network
fi
done

echo 'Updating Plugins'
wp plugin update --all
