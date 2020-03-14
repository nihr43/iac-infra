#!/bin/sh
#
# provision a base alpine container

project="$1"
instance="$2"

${project}/scripts/rnd_move.sh "$instance"

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
