#!/bin/bash
echo "Let it begin"
apachectl -f /etc/apache2/apache2.conf
echo "It is over"
while true; do sleep 1000; done