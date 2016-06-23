#!/usr/bin/env bash

echo 'Creating host files...'
cd /vagrant/www/wordpress-skydreams/htdocs/

wp db query "SELECT domain FROM wp_domain_mapping wdm WHERE wdm.active = 1" | sed 1d | while read -r url
do
cd /vagrant/www/wordpress-skydreams/domains

mkdir $url -p

cd $url

echo $url > vvv-hosts
done
