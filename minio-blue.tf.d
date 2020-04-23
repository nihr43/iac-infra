resource "lxd_container" "minio-blue" {
  count  = 4
  name   = "minio-blue-${count.index}"
  image  = "alpine/stable"
  limits = { cpu = 2 }
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
