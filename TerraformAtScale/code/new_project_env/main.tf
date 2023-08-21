terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.42.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.ado_organization_url
  personal_access_token = var.ado_organization_pat
}

provider "tfe" {
  token = "${var.tfe_token_api}"
}

module "ado_repository_file" {
  source = "../ado_tfe_modules/ado_repository_file"

  name                          = "${var.client_name}-${var.account_name}"
  envs                          = var.envs
  client_name                   = var.client_name
  account_name                  = var.account_name
  project_id                    = data.azuredevops_project.ado_project.project_id
  repository_id                 = data.azuredevops_git_repository.ado_repository.id

}

module "tfe_shared_variables" {
  source = "../ado_tfe_modules/tfe_shared_variables"

  for_each                      = toset(var.envs)
  workspace_variable_set_name   = "${var.client_name}-${var.account_name}-${each.key}-variables"
  workspace_variables           = var.tfe_workspace_variables
}


module "tfe_workspaces" {
  source = "../ado_tfe_modules/tfe_workspaces"

  # Gambiarra pra importar o project_id pois ainda não existe este datasource no tfe_provider
  project_id                    = lookup(data.external.tfe_projects_list.result, "${var.client_name}", "not found")

  auto_apply                    = false
  for_each                      = toset(var.envs)
  workspace_variable_set_id     = module.tfe_shared_variables[each.key].variable_set_id
  workspace_name                = "${var.client_name}-${var.account_name}-${each.key}"
  env                           = each.key
  client_name                   = var.client_name
  account_name                  = var.account_name
  ado_tfe_oauth_token           = var.ado_tfe_oauth_token
}


