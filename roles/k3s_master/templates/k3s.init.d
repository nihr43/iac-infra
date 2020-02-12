#!/sbin/openrc-run

supervisor=supervise-daemon
respawn_delay=10
respawn_max=0
healthcheck_timer=30

name="k3s"
command="/usr/bin/k3s"
command_args="$K3S_OPTS"
command_background="yes"
pidfile="/run/k3s.pid"

depend() {
	need net
	after firewall
}
