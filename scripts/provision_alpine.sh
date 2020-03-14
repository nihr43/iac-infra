#!/bin/sh
#
# provision a base alpine container

hash lxc jq ansible-playbook || {
  echo "missing dependencies"
  exit 1
}

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

# execute minimal setup over api
lxc exec "$instance" -- sh -c '
  until ping -c1 10.0.0.55 ; do
    sleep 1
  done
  set -e
  apk update
  apk add openssh python3 --no-cache
  passwd -u root
  sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config
  mkdir /root/.ssh
  wget https://github.com/nihr43.keys -O /root/.ssh/authorized_keys
  rc-update add sshd
  rc-service sshd start
' || {
  exit 1
}

# upgrade and provision
ansible-playbook ./actions/alpine_update/tasks/main.yml --limit="$instance"
ansible-playbook ./main.yml --limit="$instance"
