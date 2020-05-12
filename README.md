# Semantic Mediawiki Containerized

I just want a semantic mediawiki deployment that is easy to backup and restore.

## Default Database Settings

domain name : database \
username    : wikiuser \
password    : example

## Instructions

``` bash
docker-compose up
# navigate into localhost:8080
# Follow instructions and download LocalSettings.php
# Add LocalSettings.php to this folder
# add "enableSemantics( 'testwiki.local' );" to end of LocalSettings.php
bash copy.sh
bash update.sh
```

## Links that helps with the creation of this docker container

<https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive>

<https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md>

<https://askubuntu.com/questions/256013/apache-error-could-not-reliably-determine-the-servers-fully-qualified-domain-n#256018>

<https://silvae86.github.io/2018/10/28/how-to-install-semantic-mediawiki/>