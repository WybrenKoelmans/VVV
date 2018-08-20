#!/usr/bin/env bash

#
# This command expects to be run in the Homedeal wordpress root folder
#

# Use the flag --test or --prod when using in one of these environments. The default is dev.
if [ "$1" = "--test" ]; then
    env=".test.skydreams.com"
elif [ "$1" = "--prod" ]; then
    env=""
else
    env=".dev.skydreams.com"
fi

wp search-replace 'HomeDeal' 'Homedeal' --include-columns="post_content,post_title" --url="homedeal.nl$env" wp_*_posts
wp search-replace 'HomeDeal' 'Homedeal' --url="homedeal.nl$env" wp_*_comments
wp search-replace 'HomeDeal' 'Homedeal' --include-columns="option_value" --url="homedeal.nl$env" wp_*_options
wp search-replace 'HomeDeal' 'Homedeal' --include-columns="meta_value" --url="homedeal.nl$env" wp_*_postmeta wp_*_termmeta
