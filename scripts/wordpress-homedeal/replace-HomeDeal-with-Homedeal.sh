#!/usr/bin/env bash

wp search-replace 'HomeDeal' 'Homedeal' --include-columns="post_content,post_title" --url="homedeal.nl.dev.skydreams.com" wp_*_posts
wp search-replace 'HomeDeal' 'Homedeal' --url="homedeal.nl.dev.skydreams.com" wp_*_comments
wp search-replace 'HomeDeal' 'Homedeal' --include-columns="option_value" --url="homedeal.nl.dev.skydreams.com" wp_*_options
wp search-replace 'HomeDeal' 'Homedeal' --include-columns="meta_value" --url="homedeal.nl.dev.skydreams.com" wp_*_postmeta wp_*_termmeta
