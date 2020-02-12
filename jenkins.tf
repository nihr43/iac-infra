resource "lxd_container" "jenkins-private" {
  count     = 1
  name      = "jenkins-private-${count.index}"
  image     = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
  limits = { cpu = 2 }
  config = {
    "security.nesting" = true
    "security.privileged" = true
  }
}
