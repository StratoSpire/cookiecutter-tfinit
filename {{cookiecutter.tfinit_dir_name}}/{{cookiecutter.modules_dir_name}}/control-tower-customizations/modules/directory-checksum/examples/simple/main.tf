module "directory_checksum" {
  source = "../../"

  directory = "${path.module}/example-directory"
}
