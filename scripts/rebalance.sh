#!/bin/sh
#
# given a set like ^test-[0-9], scatter instances randomly across cluster

hash lxc jq || {
  echo "missing dependencies"
  exit 1
}

set -e

group="$1"

[ "$group" != "" ] || exit 1

lxc ls --format=json | jq -r .[].name | grep -E "^${group}" | {
  while read -r i ; do
    current_node="$(lxc info "$i" | awk '/Location: /{print $NF}')"
    target_node="$(lxc cluster ls --format json \
                     | jq -r .[].server_name \
                     | shuf -n1)"

    # lxd crashes if you attempt to perform a no-op move
    [ "$target_node" = "$current_node" ] || {
      printf "\033[0;32mrebalancing %s from %s to %s\033[0m\n" "$i" \
                                                               "$current_node" \
                                                               "$target_node"
      lxc stop "$i"
      lxc mv "$i" --target="$target_node"
      lxc start "$i"
    }
  done
}
