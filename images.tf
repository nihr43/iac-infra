resource "lxd_cached_image" "alpine" {
  source_remote = "images"
  source_image  = "alpine/3.10"
  aliases = ["alpine/stable"]
}
