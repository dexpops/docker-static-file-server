#!/bin/sh
set -e

envsubst < /default.conf.template > /etc/nginx/conf.d/default.conf

echo "Downloading snapshots /var/www/static/$FILENAME $URL"
wget -O /var/www/static/$FILENAME $URL

exec nginx -g 'daemon off;'