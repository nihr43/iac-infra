resource "lxd_container" "jenkins" {
  count = 1
  name  = "jenkins-${count.index}"
  image = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
