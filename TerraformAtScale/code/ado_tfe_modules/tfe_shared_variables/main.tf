terraform {
  required_providers {
    tfe = {
      version = "~> 0.42.0"
    }
  }
}

resource "tfe_variable_set" "variable_set" {
  name         = var.workspace_variable_set_name
  description  = "Varset para conta ${var.workspace_variable_set_name}"
  organization = var.organization_name
}

resource "tfe_variable" "variable" {
    for_each = { for k, v in var.workspace_variables : k => v }

    category                = "env"
    description             = "Devops secret key id da conta ${tfe_variable_set.variable_set.name}"
    hcl                     = false
    key                     = each.key
    value                   = each.value.value
    sensitive               = each.value.sensitive
    variable_set_id         = tfe_variable_set.variable_set.id
}

