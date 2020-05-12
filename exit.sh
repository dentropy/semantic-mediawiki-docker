#!/bin/bash
docker stop smw
docker rm smw
docker volume rm mytry_db
docker volume rm mytry_mediawiki
