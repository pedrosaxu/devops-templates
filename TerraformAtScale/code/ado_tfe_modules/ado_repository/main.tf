terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

resource "azuredevops_git_repository" "account_repository" {
  default_branch = var.default_branch
  name           = var.name
  project_id     = var.project_id

  initialization {
    init_type = "Clean"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to initialization to support importing existing repositories
      # Given that a repo now exists, either imported into terraform state or created by terraform,
      # we don't care for the configuration of initialization against the existing resource
      initialization,
    ]
  }
}

resource "azuredevops_git_repository_file" "images" {
  repository_id       = azuredevops_git_repository.account_repository.id
  file                = "images/arquitetura.png"
  content             = filemd5("${path.module}/git_file_templates/images/arquitetura.png")
  branch              = var.default_branch
  commit_message      = "Committing default Images folder"
  overwrite_on_create = false

}

resource "azuredevops_git_repository_file" "gitignore" {
  repository_id       = azuredevops_git_repository.account_repository.id
  file                = ".gitignore"
  content             = file("${path.module}/git_file_templates/template-git-ignore")
  branch              = var.default_branch
  commit_message      = "Committing default GitIgnore file"
  overwrite_on_create = false

}

resource "azuredevops_git_repository_file" "readme" {
  repository_id       = azuredevops_git_repository.account_repository.id
  file                = "README.md"
  content             = file("${path.module}/git_file_templates/template-readme.md")
  branch              = var.default_branch
  commit_message      = "Committing default README file"
  overwrite_on_create = true

}

resource "azuredevops_git_permissions" "devops_permission" {
  project_id = var.project_id
  principal  = data.azuredevops_group.devops_group.id
  permissions = {
    PolicyExempt = "Allow"
  }
}

