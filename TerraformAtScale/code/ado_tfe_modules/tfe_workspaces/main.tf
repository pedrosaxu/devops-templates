terraform {
  required_providers {
    tfe = {
      version = "~> 0.42.0"
    }
  }
}

resource "tfe_workspace" "workspace" {
  project_id                    = var.project_id  
  allow_destroy_plan            = true
  auto_apply                    = var.auto_apply
  description                   = "Workspace for ${var.workspace_name} resources."
  global_remote_state           = false
  name                          = "${var.workspace_name}"
  organization                  = var.organization_name
  queue_all_runs                = false
  speculative_enabled           = true
  structured_run_output_enabled = true
  terraform_version             = "1.2.9"
  vcs_repo {
    oauth_token_id = "${var.ado_tfe_oauth_token}"
    identifier     = "${var.organization_name}/${var.client_name}/_git/${var.client_name}-${var.account_name}"
  }
  working_directory             = "${var.env}/"
  tag_names                     = ["${var.workspace_name}"]
  file_triggers_enabled         = true
  trigger_patterns              = ["${var.env}/", "modules/"]
}


resource "tfe_workspace_variable_set" "workspace_variable_set" {

  workspace_id    = tfe_workspace.workspace.id
  variable_set_id = var.workspace_variable_set_id

}

