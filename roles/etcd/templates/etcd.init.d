#!/sbin/openrc-run
# Copyright 2016 Alpine Linux
# Distributed under the terms of the GNU General Public License v2
# $Id$
supervisor=supervise-daemon

name="$RC_SVCNAME"
description="Highly-available key-value store"

command=/usr/bin/etcd
command_args="--config-file=$ETCD_CONFIG --data-dir=$ETCD_DATA_DIR $ETCD_OPTS"

command_user="$USER:$USER"

supervise_daemon_args="--chdir $ETCD_DATA_DIR"

depend() {
        need net
}

start_pre() {
        checkpath -d -m 0775 -o "$command_user" "$LOGPATH"
        checkpath -d -m 0775 -o "$command_user" "$ETCD_DATA_DIR"
}
