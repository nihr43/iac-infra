#!/sbin/openrc-run
# (c) 2016 Alpine Linux

supervisor=supervise-daemon
respawn_delay=10
respawn_max=0
healthcheck_timer=30

command="/usr/sbin/lxd"
command_args="${LXD_OPTIONS}"
command_background="true"
pidfile="/var/run/${RC_SVCNAME}.pid"

depend() {
  need net
  use lxcfs
  after firewall
}
