resource "aws_cloudformation_stack" "controltower_customization_initialization" {
  name               = "ControlTowerCustomizationInitiation"
  timeout_in_minutes = "240"
  disable_rollback   = false

  parameters = {
    PipelineApprovalStage    = var.pipeline_approval_stage ? "Yes" : "No"
    PipelineApprovalEmail    = var.pipeline_approval_email != "" ? "Yes" : "No"
    CodePipelineSource       = "AWS CodeCommit"
    CodeCommitRepositoryName = var.code_commit_repository_name
    CodeCommitBranchName     = var.code_commit_branch_name
    ExistingRepository       = "No"
  }

  capabilities = ["CAPABILITY_NAMED_IAM"]

  template_url = "https://s3.amazonaws.com/solutions-reference/customizations-for-aws-control-tower/v${var.customizations_version}/custom-control-tower-initiation.template"
}

data "aws_region" "current" {}

module "config_checksum" {
  source    = "../directory-checksum"
  directory = var.config_directory
}

# Push ControlTower customizations config directory to AWS CodeCommit using `git` shell command
resource "null_resource" "push_customizations" {
  triggers = {
    script_checksum = filemd5("${path.module}/scripts/push_customizations.sh")
    config_checksum = module.config_checksum.checksum
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/push_customizations.sh ${var.code_commit_repository_name} ${var.code_commit_branch_name} ${self.triggers.script_checksum} ${var.config_directory} ${var.git_user_name} ${var.git_user_email} ${var.git_commit_message}"
    environment = {
      AWS_DEFAULT_REGION = "${data.aws_region.current.name}"
    }
  }

  depends_on = [aws_cloudformation_stack.controltower_customization_initialization]
}
