module "controltower_customizations" {
  source                      = "../../../../../modules/control-tower-customizations"
  config_directory            = abspath("${path.module}/files/custom-control-tower-configuration")
  code_commit_repository_name = "{{cookiecutter.code_commit_repository_name}}"
  git_user_name               = "{{cookiecutter.code_commit_git_user_name}}"
  git_user_email              = "{{cookiecutter.code_commit_git_user_email}}"
}
