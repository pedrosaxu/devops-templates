terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}


resource "azuredevops_project" "client_project" {
  features = {
    "pipelines" = "disabled"
    "testplans" = "disabled"
    "boards"    = "disabled"
    "artifacts" = "disabled"
  }

  name               = "${var.name}"
  description        = "Criado em ${formatdate("DD MMM YYYY hh:mm", timeadd(timestamp(), "-3h"))}. Este projeto foi criado para armazenamento de IaC do cliente."
  version_control    = "Git"
  visibility         = "private"
  work_item_template = "Basic"

}

resource "azuredevops_group_membership" "project_contributor_group_membership" {
  group = data.azuredevops_group.project_contributors.descriptor
  members = [
    data.azuredevops_group.ops_group.descriptor,
    data.azuredevops_group.deploy_group.descriptor,
  ]
}