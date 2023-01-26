#!/usr/bin/env bash

set -e

function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f $(which k0sctl) || error_exit "k0sctl command not detected in path, please install it"
  test -f $(which jq) || error_exit "jq command not detected in path, please install it"
  test -f $(which sed) || error_exit "sed command not detected in path, please install it"
}

function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
  eval "$(jq -r '@sh "export PUBLIC_IP=\(.kubeapiIp)"')"
  [[ -n "${PUBLIC_IP}" ]] || error_exit "kubeapiIp not found"
}

function get_kubeconfig() {
  kubeconfig="$(k0sctl kubeconfig -c /tmp/k0sctl.yaml| sed "s/server: https:\/\/.*:/server: https:\/\/${PUBLIC_IP}:/")"
  cluster_ca_certificate="$(echo "${kubeconfig}" | grep certificate-authority-data: | sed 's/.*: //')"
  client_certificate="$(echo "${kubeconfig}" | grep client-certificate-data: | sed 's/.*: //')"
  client_key="$(echo "${kubeconfig}" | grep client-key-data: | sed 's/.*: //')"
  jq -n \
    --arg kubeconfig "${kubeconfig}" \
    --arg cluster_ca_certificate "${cluster_ca_certificate}" \
    --arg client_certificate "${client_certificate}" \
    --arg client_key "${client_key}" \
    '{"kubeconfig": $kubeconfig, "kubeconfig_base64": $kubeconfig | @base64, "cluster_ca_certificate": $cluster_ca_certificate, "client_certificate": $client_certificate, "client_key": $client_key}'
}


check_deps
parse_input
get_kubeconfig
