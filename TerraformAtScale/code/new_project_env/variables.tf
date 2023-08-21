##################### PASSED VIA MORPHEUS PYTHON APP #####################

variable "client_name" {
  type        = string
  description = "The name of the client"
}

variable "account_name" {
  type        = string
  description = "The name of the account"
}

variable "envs" {
  type        = list(string)
  description = "The name of the envs of the repository to create."
}

variable "ado_organization_pat" {
  type        = string
  description = "The Personal Access Token (PAT) of the Azure DevOps organization"
  sensitive = true
}

variable "tfe_token_api" {
  type        = string
  description = "The organization token of the Terraform Cloud API"
  sensitive = true
}

variable "ado_tfe_oauth_token" {
  description = "Azure DevOps OAuth token for TFCloud"
  type = string
  sensitive = true
}

variable "tfe_workspace_variables" {
  description = "Variables of TFCloud organization:"
  type        = map(any)
  default = {
    AWS_ACCESS_KEY_ID = {
      value = "empty",
      sensitive = false
    }, 
    AWS_SECRET_ACCESS_KEY = {
      value = "empty", 
      sensitive = true
    }, 
    ARM_SUBSCRIPTION_ID= { 
      value = "empty", 
      sensitive = false
    },
    ARM_TENANT_ID = {
      value = "empty", 
      sensitive = false
    }, 
    ARM_CLIENT_ID = { 
      value = "empty",
      sensitive = false
    },
    ARM_CLIENT_SECRET = {
      value = "empty", 
      sensitive = true
    }
  }
}

######################## REASONABLE DEFAULT VALUES ########################

variable "ado_organization_url" {
  type        = string
  description = "The URL of the Azure DevOps organization"
  default     = "https://dev.azure.com/pedrosaxu"
}







