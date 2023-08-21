terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.ado_organization_url
  personal_access_token = var.ado_organization_pat
}

module "ado_repository" {
  source                        = "../ado_tfe_modules/ado_repository"

  project_id                    = data.azuredevops_project.ado_project.project_id
  name                          = "${var.client_name}-${var.account_name}"
  default_branch                = "refs/heads/main"
  envs                          = var.envs
  client_name                   = var.client_name
  account_name                  = var.account_name

}

module "ado_branch_policies" {
  source           = "../ado_tfe_modules/ado_branch_policies"

  project_id       = data.azuredevops_project.ado_project.project_id
  repo_id          = module.ado_repository.repository_id
  repo_name        = module.ado_repository.repository_name
  lock_approval    = false
  branch_name      = module.ado_repository.repository_default_branch

  depends_on       = [ module.ado_repository ]
}


