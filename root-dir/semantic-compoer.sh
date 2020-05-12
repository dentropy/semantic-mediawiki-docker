#!/bin/bash

cd /var/www/html
echo "Adding semantic wiki stuff"
composer require mediawiki/semantic-media-wiki "3.0.0" --update-no-dev
composer require mediawiki/semantic-result-formats "3.0.0"
echo "Added semantic wiki stuff, about to update"
composer update --prefer-source
echo "Done updating"