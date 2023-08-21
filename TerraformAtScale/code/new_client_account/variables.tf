##################### PASSED VIA MORPHEUS PYTHON APP #####################

variable "client_name" {
  type        = string
  description = "The name of the client"
}

variable "ado_organization_pat" {
  type        = string
  description = "The Personal Access Token (PAT) of the Azure DevOps organization"
}

variable "tfe_token_api" {
  type        = string
  description = "The token of the Terraform Cloud API"
}


######################## REASONABLE DEFAULT VALUES ########################

variable "ado_organization_url" {
  type        = string
  description = "The URL of the Azure DevOps organization"
  default     = "https://dev.azure.com/pedrosaxu"
}

