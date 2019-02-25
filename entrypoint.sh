#!/bin/sh
set -e

envsubst < /default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'