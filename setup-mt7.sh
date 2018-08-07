#!/bin/bash

# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your enviornment."
    exit 1
fi

mkdir -p /var/www/local/cgi-bin

# ===========================
# Movable Type Setting
# ===========================
cp ./mt-data/${MOVABLETYPE_ZIPNAME} ${CGI_BASE_PATH}/
unzip '/var/www/local/cgi-bin/MT-7.0.zip' -d '/var/www/local/cgi-bin/'
mv ${CGI_BASE_PATH}/${MOVABLETYPE_ZIPNAME} ${CGI_BASE_PATH}/mt
cp mt-settings/plugins /var/www/local/cgi-bin/mt/plugins/
cp mt-settings/mt-static/plugins /var/www/local/cgi-bin/mt/mt-static/plugins/
chown -R apache:apache ${CGI_BASE_PATH}/mt
chmod 777 /var/www/
chmod 777 /var/www/local
chmod 755 ${CGI_BASE_PATH}/mt/*.cgi