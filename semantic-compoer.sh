#!/bin/bash
cd /var/www/html
php /composer.phar require mediawiki/semantic-media-wiki "3.0.0" --update-no-dev
php /composer.phar require mediawiki/semantic-result-formats "3.0.0"