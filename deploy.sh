#!/bin/sh

# read past the '--' argument
while [[ $# -gt 0 ]]; do
  current="$1"
  shift
  [[ "$current" = "--" ]] && break
done

payload="$@"

set -e

j () {
  echo "$payload" | jq -r "$1"
}

j .vargs.certificate_authority_data > ca.pem
j .vargs.client_certificate_data > client.pem
j .vargs.client_key_data > client-key.pem

kubectl config set-cluster default \
  --server=`j .vargs.api_server` \
  --certificate-authority=`pwd`/ca.pem

kubectl config set-credentials default \
  --client-certificate=`pwd`/client.pem \
  --client-key=`pwd`/client-key.pem

kubectl --cluster=default --user=default apply -f `j .resource_file // "/drone/kubernetes.yaml"`
