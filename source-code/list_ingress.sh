#!/bin/sh

TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
CA_CERT="/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
API_SERVER="https://kubernetes.default.svc.cluster.local"

# Fetch Traefik's IngressRoute resources from all namespaces
if [ -z "$FILTER_PATTERN" ]; then
    curl -s --cacert $CA_CERT -H "Authorization: Bearer $TOKEN" \
         $API_SERVER/apis/networking.k8s.io/v1/ingresses | \
    jq '[.items[] | {name: .metadata.name, namespace: .metadata.namespace, host: .spec.rules[].host, path: (.spec.rules[].http.paths[]?.path // "/")}]' > /app/ingresses.json
else
    curl -s --cacert $CA_CERT -H "Authorization: Bearer $TOKEN" \
         $API_SERVER/apis/networking.k8s.io/v1/ingresses | \
    jq --arg pattern "$FILTER_PATTERN" '[.items[] | select(.metadata.name | test($pattern)) | {name: .metadata.name, namespace: .metadata.namespace, host: .spec.rules[].host, path: (.spec.rules[].http.paths[]?.path // "/")}]' > /app/ingresses.json
fi
