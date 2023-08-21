data "azuredevops_group" "project_contributors" {
  project_id = azuredevops_project.client_project.id
  name       = "Contributors"
}

data "azuredevops_group" "deploy_group" {
  name = "deploy_users"
}

data "azuredevops_group" "ops_group" {
  name = "ops_users"
}