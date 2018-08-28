#!/bin/bash

#
# This command expects to be run in the Homedeal wordpress root folder
#

number_quotes=4

for blogId in $(wp site list --allow-root --field=blog_id)
do
    domain=$(wp site list --site__in=$blogId --field=domain)

    if [[ "$domain" == "homedeal.nl"* ]]; then
        echo "$domain"
        wp theme mod set default_number_quotes ${number_quotes} --url=${domain}
    fi
done

