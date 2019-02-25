#!/bin/sh
set -e

envsubst < /default.conf.template > /etc/nginx/conf.d/default.conf

echo "Downloading BTC,BLOCK snapshots..."
wget -O /var/www/static/utxo-snapshot-bitcoin.tar http://utxosets.blob.core.windows.net/public/utxo-snapshot-bitcoin-mainnet-551636.tar
wget -O /var/www/static/blocknetdex.zip https://github.com/BlocknetDX/blocknet-blockchain-bootstrap/releases/download/v1.0/BlocknetDX.zip

exec nginx -g 'daemon off;'