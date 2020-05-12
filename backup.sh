#!/bin/bash

# Just create a database dump of the mariadb database
docker exec mytry_database_1 sh -c 'exec mysqldump --all-databases -uwikiuser -pexample' > ./semantic-mediawiki.sql

# Backup semantic mediawiki volume
docker run -v mytry_mediawiki --name dbstore ubuntu:18.04 /bin/bash
docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata
docker stop dbstore
docker rm dbstore