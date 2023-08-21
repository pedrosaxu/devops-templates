
variable "project_id" {
  type        = string
  description = "The id of the project to create."
}

variable "workspace_name" {
  description = "Workspaces of TFCloud organization:"
  type        = string
}

variable "env" {
  description = "Ambiente"
  type = string
}

variable "client_name" {
  description = "Client name"
  type = string
}

variable "account_name" {
  description = "Account name"
  type = string
}

variable "workspace_variable_set_id" {
  description = "Variable set id of TFCloud workspace:"
  type        = string
}

variable "auto_apply" {
  description = "Auto apply?"
  type = bool
  default = false
}

variable "ado_tfe_oauth_token" {
  description = "Azure DevOps OAuth token for TFCloud"
  type = string
  sensitive = true
}

######################## REASONABLE DEFAULT VALUES ########################
variable "organization_name" {
  type        = string
  description = "The name of the organization"
  default     = "pedrosaxu"
}
