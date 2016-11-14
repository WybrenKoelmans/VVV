#!/usr/bin/env bash

install_gulp() {
    if [[ "$(gulp --version)" ]]; then
        echo "Updating Gulp CLI"
        sudo npm update -g gulp-cli
    else
        echo "Installing Gulp CLI"
        sudo npm install -g gulp-cli
    fi
}

install_dashboard() {
    if [ ! -d  /vagrant/www/default/dashboard ]; then
        git clone https://github.com/topdown/VVV-Dashboard.git /vagrant/www/default/dashboard
        cp /vagrant/www/default/dashboard/dashboard-custom.php /vagrant/www/default/dashboard-custom.php
    fi
}

( exec "/vagrant/scripts/extract-theme-node-modules.sh" )
