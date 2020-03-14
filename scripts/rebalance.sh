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
    ./rnd_move.sh "$i"
  done
}
