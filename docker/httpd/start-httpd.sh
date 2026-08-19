#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
/usr/local/bin/sync-theme-static.sh
exec /usr/sbin/httpd -D FOREGROUND
