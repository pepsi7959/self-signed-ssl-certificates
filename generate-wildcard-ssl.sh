#!/usr/bin/env bash

HOST_NAME="advancedlogic.co"
ORGANIZE="advancedlogic Ltd"
ORGANIZE_UNIT="advancedlogic"
EMAIL="narongsak.mala@gmail.com"

# Specify where we will install
# the example.com certificate
SSL_DIR="/etc/ssl/${HOST_NAME}"

# Set the wildcarded domain
# we want to use
DOMAIN="*.${HOST_NAME}"

# A blank passphrase
PASSPHRASE=""

# Set our CSR variables
SUBJ="
C=TH
ST=Bangkok
O=${ORGANIZE}
localityName=Bangkok
commonName=${DOMAIN}
organizationalUnitName=${ORGANIZE_UNIT}
emailAddress=${EMAIL}
"
# Create our SSL directory
# in case it doesn't exist
sudo mkdir -p ${SSL_DIR}

# Generate our Private Key, CSR and Certificate
sudo openssl genrsa -out "${SSL_DIR}/${HOST_NAME}.key" 2048
sudo openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "${SSL_DIR}/${HOST_NAME}.key" -out "${SSL_DIR}/${HOST_NAME}.csr" -passin pass:$PASSPHRASE
sudo openssl x509 -req -days 365 -in "${SSL_DIR}/${HOST_NAME}.csr" -signkey "${SSL_DIR}/${HOST_NAME}.key" -out "${SSL_DIR}/${HOST_NAME}.crt"
