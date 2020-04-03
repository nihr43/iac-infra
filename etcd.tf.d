resource "lxd_container" "haproxy-etcd" {
  count  = 2
  name   = "haproxy-etcd-${count.index}"
  image  = "alpine/stable"
  limits = { cpu = 2 }
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}

resource "lxd_container" "etcd" {
  count  = 3
  name   = "etcd-${count.index}"
  image  = "alpine/stable"
  limits = { cpu = 2 }
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
