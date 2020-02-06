resource "lxd_container" "docker-registry" {
  count     = 2
  name      = "docker-registry-${count.index}"
  image     = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
