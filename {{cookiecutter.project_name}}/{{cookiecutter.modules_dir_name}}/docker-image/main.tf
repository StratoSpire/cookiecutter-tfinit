locals {
  ecr_address = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
  ecr_repo    = var.create_ecr_repo ? aws_ecr_repository.this[0].id : var.name
  #images     = "${local.ecr_address}/${local.ecr_repo}"
  images = [for x in var.tags : "${local.ecr_address}/${local.ecr_repo}:${x}"]
}

data "aws_region" "current" {}
data "aws_caller_identity" "this" {}

resource "aws_ecr_repository" "this" {
  count = var.create_ecr_repo ? 1 : 0

  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

module "context_checksum" {
  source    = "../directory-checksum"
  directory = var.source_path
}

resource "docker_registry_image" "this" {
  count = length(local.images)
  name  = local.images[count.index]

  build {
    context    = var.source_path
    dockerfile = var.docker_file_path
    build_id   = module.context_checksum.checksum
  }

  depends_on = [
    aws_ecr_repository.this
  ]
}
