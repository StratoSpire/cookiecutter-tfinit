data "external" "checksum" {
  program = ["${path.module}/scripts/checksum.sh"]
  query = {
    directory = var.directory
  }
}
