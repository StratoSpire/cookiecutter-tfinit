variable "customizations_version" {
  description = "Version of AWS Control Tower Customizations"
  type        = string
  default     = "2.1.0"
}

variable "tags" {
  description = "Tags to assign to created resources"
  type        = map(any)
  default     = {}
}

variable "pipeline_approval_stage" {
  description = "Do you want to add a manual approval stage to the Custom Control Tower Configuration Pipeline?"
  type        = bool
  default     = false
}

variable "pipeline_approval_email" {
  description = "Not required if Pipeline Approval Stage = 'No') Email for notifying that the CustomControlTower pipeline is waiting for an Approval"
  type        = string
  default     = ""
}

variable "code_commit_repository_name" {
  description = "Name of the CodeCommit repository that contains custom Control Tower configuration. The suffix .git is prohibited."
  type        = string
  default     = "custom-control-tower-configuration"
}

variable "code_commit_branch_name" {
  description = "Name of the branch in CodeCommit repository that contains custom Control Tower configuration."
  type        = string
  default     = "main"
}

variable "config_directory" {
  description = "Directory containing ControlTower customizations config files"
  type        = string
}

variable "git_user_name" {
  description = "Name to use for git commit messages"
  type        = string
}

variable "git_user_email" {
  description = "Email address to use for git commit messages"
  type        = string
}

variable "git_commit_message" {
  description = "Name to use for git commit messages"
  type        = string
  default     = "Automated Commit from Terraform"
}
