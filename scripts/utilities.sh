#!/bin/sh

set -e

hash ansible-playbook git jq lxc || {
  echo "missing dependencies"
  exit 1
}

action="$1"
instance="$2"

project="$(git rev-parse --show-toplevel)"

case $action in
  provision)
    "${project}"/scripts/provision_alpine.sh "$project" "$instance"
  ;;
  *)
    echo "no action provided"
    exit 1
esac
