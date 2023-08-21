terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

resource "azuredevops_git_repository_file" "envs_paths" {
  for_each = toset(var.envs)

  repository_id       = var.repository_id
  file                = "${each.value}/main.tf"
  content             = data.template_file.envs_paths[each.key].rendered
  branch              = "refs/heads/main"
  commit_message      = "Committing default environment paths' files"
  overwrite_on_create = true

}