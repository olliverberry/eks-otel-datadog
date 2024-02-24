#!/usr/bin/bash

NODE1=$(kubectl get nodes -o jsonpath="{.items[0].metadata.name}")
NODE2=$(kubectl get nodes -o jsonpath="{.items[1].metadata.name}")

APP_TAINT="tier=apps:NoSchedule"
OTEL_TAINT="tier=otel-collector:NoSchedule"

echo "tainting node $NODE1 with taint $APP_TAINT"
kubectl taint nodes $NODE1 $APP_TAINT

echo "tainting node $NODE2 with taint $OTEL_TAINT"
kubectl taint nodes $NODE2 $OTEL_TAINT