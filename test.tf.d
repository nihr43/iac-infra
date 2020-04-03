resource "lxd_container" "test" {
  count     = 1
  name      = "minio-prod-1"
  image     = "alpine/stable"
  provisioner "local-exec" { command = "scripts/provision_alpine.sh ${self.name}" }
  limits = { cpu = 2 }
}
