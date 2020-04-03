resource "lxd_container" "haproxy-elasticsearch" {
  count = 2
  name  = "haproxy-elasticsearch-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}

resource "lxd_container" "elasticsearch" {
  count = 2
  name  = "elasticsearch-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
