#!/bin/bash
#
# drain a given lxd node

hash lxc jq || {
  echo "missing dependencies"
  exit 1
}

set -e -o pipefail

host="$1"

[ "$host" != "" ] || exit 1

instance_list="$(lxc ls --format json \
                   | jq -r '.[] | select(.location=="'"$host"'").name')"

for instance in $instance_list ; do
  target_node="$(lxc cluster ls --format json \
                   | jq -r .[].server_name \
		   | grep -v "$host" \
		   | shuf -n1)"

  printf "\033[0;32mdraining %s from %s to %s\033[0m\n" \
    "$instance" \
    "$host" \
    "$target_node"
  lxc stop "$instance" || {
    echo "the container is already stopped"
  }
  lxc mv "$instance" --target="$target_node"
  lxc start "$instance"
done
