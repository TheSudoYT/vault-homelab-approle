#!/bin/bash

VAULT_ADDR='https://vault.lab.com:8200' 
ROLE_ID=''
SECRET_ID=''
COMMON_NAME='monitor.lab.com'
PKI_ENGINE_PATH=' intermediate_ca'
ROLE_NAME='lab-dot-com'

export VAULT_ADDR

# Authenticate to Vault 
VAULT_TOKEN=$(vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID" -format=json | jq -r '.auth.client_token')

export VAULT_TOKEN

# Request certificate 
vault write $PKI_ENGINE_PATH/issue/$ROLE_NAME common_name="$COMMON_NAME" ttl="365d" -format=json > cert.json
cat cert.json | jq -r '.data.certificate' > "$COMMON_NAME.crt"
cat cert.json | jq -r '.data.private_key' > "$COMMON_NAME.key"
cat cert.json | jq -r '.data.issuing_ca' > ca.crt                                                  
