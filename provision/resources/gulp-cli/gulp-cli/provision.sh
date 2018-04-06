#!/usr/bin/env bash

if [[ "$(gulp --version)" ]]; then
    echo "Updating Gulp CLI"
    sudo npm update -g gulp-cli
else
    echo "Installing Gulp CLI"
    sudo npm install -g gulp-cli
fi

