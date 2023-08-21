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
}

######################## REASONABLE DEFAULT VALUES ########################

variable "ado_organization_url" {
  type        = string
  description = "The URL of the Azure DevOps organization"
  default     = "https://dev.azure.com/pedrosaxu"
}







