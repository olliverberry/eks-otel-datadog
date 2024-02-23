#!/usr/bin/bash

DD_API_KEY=$1

if [[ -z "$DD_API_KEY" ]]; then
    echo "DD_API_KEY not set, exiting"
    exit 1
fi

kubectl create secret generic dd-secrets \
    --from-literal dd-api-key=$DD_API_KEY