#!/bin/bash

# Restore mariadb database
docker exec -i semanticmediawikidocker_database_1 sh -c 'exec mysql -uwikiuser -pexample' < ./semantic-mediawiki.sql
echo "Database Restore Complete"
