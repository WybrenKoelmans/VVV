#!/usr/bin/env bash

echo 'Creating host files...'
cd /vagrant/www/wordpress-skydreams/htdocs/

wp db query "SELECT domain FROM wp_domain_mapping wdm WHERE wdm.active = 1 ORDER BY domain" | sed 1d | while read -r url
do
    echo '192.168.50.4 '$url >> /vagrant/scripts/domainHosts.txt
done

cd /vagrant/www/wordpress-homedeal/htdocs/

wp db query "SELECT domain FROM wp_domain_mapping wdm WHERE wdm.active = 1 ORDER BY domain" | sed 1d | while read -r url
do
    echo '192.168.50.4 '$url >> /vagrant/scripts/domainHosts.txt
done
