#!/bin/bash

# Restore mariadb database
docker exec -i mytry_database_1 sh -c 'exec mysql -uwikiuser -pexample' < ./semantic-mediawiki.sql
echo "Database Restore Complete"
