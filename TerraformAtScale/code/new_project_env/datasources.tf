data "azuredevops_project" "ado_project" {
    name = "${var.client_name}"
}

# Gambiarra pra importar o project_id pois ainda não existe este datasource no tfe_provider
data "external" "tfe_projects_list" {
    program = ["bash", "${path.root}/get_project_id.sh"]
    query = {
      token = var.tfe_token_api
  }
}

data "azuredevops_git_repository" "ado_repository" {
  project_id = data.azuredevops_project.ado_project.id
  name       = "${var.client_name}-${var.account_name}"
}
