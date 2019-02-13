#!/bin/sh
envsubst < /default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'