#!/bin/sh
cd /var/www/local/cgi-bin/mt/
exec /usr/local/bin/starman --listen :5000 --workers 2 --user apache --group apache --error-log /var/log/starman/mt.log --pid /var/www/local/cgi-bin/mt/pids/mt.pid ./mt.psgi
#/usr/local/bin/starman -l 127.0.0.1:5000 --pid /var/www/local/cgi-bin/mt/pids/mt.pid ./mt.psgi

