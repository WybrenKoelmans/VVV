#!/usr/bin/env bash
git config --global alias.root 'rev-parse --show-toplevel'

cd $(git root)

echo "Cloning Wordpress Theme Weetjes v1.0"
if [ ! -d  www/wordpress-skydreams/public_html/wp-content/themes/weetjes ]; then
    git clone -b 1.0 git@github.com:SkyDreams/wordpress-theme-weetjes.git www/wordpress-skydreams/public_html/wp-content/themes/weetjes
fi

echo "Cloning Wordpress Theme Weetjes v2.0"
if [ ! -d  www/wordpress-skydreams/public_html/wp-content/themes/weetjes-v2 ]; then
    git clone -b 2.0 git@github.com:SkyDreams/wordpress-theme-weetjes.git www/wordpress-skydreams/public_html/wp-content/themes/weetjes-v2
fi

echo "Cloning Wordpress Theme Weetjes v2.1"
if [ ! -d  www/wordpress-skydreams/public_html/wp-content/themes/wordpress-theme-weetjes-v2.1 ]; then
    git clone -b 2.1 git@github.com:SkyDreams/wordpress-theme-weetjes.git www/wordpress-skydreams/public_html/wp-content/themes/wordpress-theme-weetjes-v2.1
fi

echo "Cloning Wordpress Theme Weetjes v3.0"
if [ ! -d  www/wordpress-skydreams/public_html/wp-content/themes/wordpress-theme-weetjes-v3.0 ]; then
    git clone -b 3.0 git@github.com:SkyDreams/wordpress-theme-weetjes.git www/wordpress-skydreams/public_html/wp-content/themes/wordpress-theme-weetjes-v3.0
fi

echo "Cloning latest WordPress Move Theme"
if [ ! -d  www/wordpress-skydreams/public_html/wp-content/themes/move ]; then
    git clone git@github.com:SkyDreams/wordpress-theme-move.git www/wordpress-skydreams/public_html/wp-content/themes/move
fi

echo "Cloning latest WordPress HomeDeal Theme"
if [ ! -d  www/wordpress-homedeal/public_html/wp-content/themes/homedeal ]; then
    git clone -b v2018.36.0 git@github.com:SkyDreams/wordpress-theme-homedeal.git www/wordpress-homedeal/public_html/wp-content/themes/homedeal
fi

echo "Cloning latest WordPress HomeDeal 2018 Theme"
if [ ! -d  www/wordpress-homedeal/public_html/wp-content/themes/homedeal-2018 ]; then
    git clone git@github.com:SkyDreams/wordpress-theme-homedeal.git www/wordpress-homedeal/public_html/wp-content/themes/homedeal-2018
fi
