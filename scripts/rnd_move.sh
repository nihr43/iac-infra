#!/bin/sh
#
## moves instance `$1` to a random node

instance="$1"

current_node="$(
  lxc info "$instance" \
    | awk '/Location: /{print $NF}'
)"

target_node="$(
  lxc cluster ls --format json \
    | jq -r .[].server_name \
    | shuf -n1
)"

# only attempt to move if a new node is selected
[ "$target_node" = "$current_node" ] || {
  printf "\033[0;32mrebalancing %s from %s to %s\033[0m" "$instance" \
                                                         "$current_node" \
                                                         "$target_node"
  lxc stop "$instance"
  lxc mv "$instance" --target="$target_node"
  lxc start "$instance"
}
