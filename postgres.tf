resource "lxd_container" "postgres" {
  count  = 1
  name   = "postgres-${count.index}"
  image  = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
