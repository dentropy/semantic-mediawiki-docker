#!/bin/bash

cd /var/www/html
echo "Adding semantic wiki stuff"
# composer require mediawiki/semantic-media-wiki "3.0.0" --update-no-dev
# composer require mediawiki/semantic-result-formats "3.0.0"
# Good artists copy; great artists steal - wirehead/semantic-mediawiki-docker
composer require mediawiki/semantic-bundle "~3.1"
composer require mediawiki/semantic-scribunto "~2.1"
composer require mediawiki/chameleon-skin "~2.1"
composer require wikimedia/css-sanitizer "2.0.1"
echo "Added semantic wiki stuff, about to update"
composer update --prefer-source
echo "Done updating"