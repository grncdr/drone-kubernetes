#!/bin/sh

# read past the '--' argument
while [[ $# -gt 0 ]]; do
  current="$1"
  shift
  [[ "$current" = "--" ]] && break
done

args=`echo $@ | jq -c .vargs`

set -e

get_arg () {
  echo "$args" | jq -r ".$1"
}

get_arg certificate_authority_data > ca.pem
get_arg client_certificate_data > client.pem
get_arg client_key_data > client-key.pem

kubectl config set-cluster default \
  --server=`get_arg api_server` \
  --certificate-authority=`pwd`/ca.pem

kubectl config set-credentials default \
  --client-certificate=`pwd`/client.pem \
  --client-key=`pwd`/client-key.pem

echo pwd:
pwd
echo ls:
ls
echo ls /drone:
ls /drone

kubectl --cluster=default --user=default apply -f `get_arg resource_file // "/drone/kubernetes.yaml"`
