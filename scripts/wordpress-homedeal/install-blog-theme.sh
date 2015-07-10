#!/usr/bin/env bash

cd /vagrant/www/wordpress-homedeal/

if ! wp theme is-installed alizee-pro --allow-root; then
	wp theme install alizee-pro.zip --allow-root
fi
