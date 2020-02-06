resource "lxd_container" "haproxy-lxd" {
  count     = 2
  name      = "haproxy-lxd-${count.index}"
  image     = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
