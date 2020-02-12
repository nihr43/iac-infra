variable "K8S_PASS" {}
variable "LXD_PASS" {}

terraform {
  backend "etcdv3" {
    endpoints = ["10.0.0.54:2379"]
    lock      = true
    prefix    = "terraform-state/"
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  lxd_remote {
    name     = "10.0.0.59"
    scheme   = "https"
    address  = "10.0.0.59"
    password = var.LXD_PASS
    default  = true
  }
}

provider "kubernetes" {
  host                   = "https://10.0.0.56:6443"
  username               = "admin"
  password               = var.K8S_PASS
  cluster_ca_certificate = file("~/.kube/cluster-ca-cert.pem")
}
