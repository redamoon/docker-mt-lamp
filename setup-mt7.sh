#!/bin/bash

# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your enviornment."
    exit 1
fi

mkdir -p /var/www/local/hoge/