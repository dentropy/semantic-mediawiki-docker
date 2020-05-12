#!/bin/bash

# Restore semantic mediawiki volume
docker volume create mytry_mediawiki
docker run -v /mytry_mediawiki --name dbstore2 ubuntu /bin/bash
docker run --rm --volumes-from dbstore2 -v $(pwd):/backup ubuntu:18.04 bash -c "cd /mytry_mediawiki && tar xvf /backup/backup.tar --strip 1"
docker stop dbstore2
docker rm dbstore2
