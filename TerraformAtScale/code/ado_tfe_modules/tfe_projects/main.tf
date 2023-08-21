terraform {
  required_providers {
    tfe = {
      version = "~> 0.42.0"
    }
  }
}

resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization_name
}