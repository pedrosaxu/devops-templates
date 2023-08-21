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

module "ado_project" {
  source            = "../ado_tfe_modules/ado_project"
  name              = "${var.client_name}"
}

module "tfe_project" {
  source            = "../ado_tfe_modules/tfe_projects"
  project_name      = "${var.client_name}"
}
