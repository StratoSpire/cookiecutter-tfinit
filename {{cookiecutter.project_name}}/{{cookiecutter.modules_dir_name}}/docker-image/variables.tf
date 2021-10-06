variable "create_ecr_repo" {
  description = "Controls whether ECR repository for Lambda image should be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of ECR repository to use or to create"
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tags for the image"
  type        = list(string)
  default     = ["latest"]
}

variable "source_path" {
  description = "Path to folder containing application code"
  type        = string
  default     = null
}

variable "docker_file_path" {
  description = "Path to Dockerfile in source package"
  type        = string
  default     = "Dockerfile"
}


variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "build_args" {
  description = "Map of build args to pass to the Docker build"
  type        = map(any)
  default     = {}
}