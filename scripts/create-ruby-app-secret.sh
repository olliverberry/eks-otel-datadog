#!/usr/bin/bash

SECRET_KEY_BASE=$1

if [[ -z "$SECRET_KEY_BASE" ]]; then
    echo "SECRET_KEY_BASE not set, exiting"
    exit 1
fi

kubectl create secret generic ruby-app-secrets \
    --from-literal secret-key-base=$SECRET_KEY_BASE