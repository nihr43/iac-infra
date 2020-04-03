resource "lxd_container" "minio-green" {
  count  = 6
  name   = "minio-green-${count.index}"
  image  = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
}
