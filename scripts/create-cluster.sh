#!/usr/bin/bash

CLUSTER_NAME=$1
REGION=$2

if [[ -z "$CLUSTER_NAME" ]]; then
    CLUSTER_NAME="test-eks-cluster"
fi

if [[ -z "$REGION" ]]; then
    REGION="us-east-1"
fi

echo "Creating cluster $CLUSTER_NAME in region $REGION"
eksctl create cluster \
    --name $CLUSTER_NAME \
    --region $REGION