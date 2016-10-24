#!/usr/bin/env bash
echo 'Creating nginx conf files for all domains...'

cd /vagrant/www/wordpress-homedeal/
mkdir -p domains

wp db query "SELECT domain FROM wp_domain_mapping wdm WHERE wdm.active = 1;" --path='/vagrant/www/wordpress-homedeal/htdocs/' | sed 1d | while read -r url
do

cd /vagrant/www/wordpress-homedeal/domains

mkdir -p $url
cd $url
cat > vvv-nginx.conf  <<EOL
server {
    # Determines the port number that nginx will listen to for this
    # server configuration. 80 is the default http port.
    listen       80;

    # Tells nginx what domain name should trigger this configuration. If
    # you would like multiple domains or subdomains, they can be space
    # delimited here. See http://nginx.org/en/docs/http/server_names.html
    server_name  $url;

    # Tells nginx which directory the files for this domain are located
    root         /srv/www/wordpress-homedeal/htdocs;

    # Includes a basic WordPress configuration to help with the common
    # rules needed by a web server to deal with WordPress properly.
    include /etc/nginx/nginx-wp-common.conf;
}

EOL
done
