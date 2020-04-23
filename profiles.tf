resource "lxd_profile" "default" {
  name = "default"

  config = {
    "boot.autostart" = true
    "limits.cpu" = 2
  }

  device {
    name = "eth0"
    type = "nic"

    properties = {
      nictype = "bridged"
      parent  = "br0"
    }
  }

  device {
    name = "root"
    type = "disk"

    properties = {
      pool = "local"
      path = "/"
    }
  }
}
