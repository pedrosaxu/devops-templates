variable "workspace_variable_set_name" {
    type        = string
    description = "The name of the Terraform Cloud variable set:"
}

variable "workspace_variables" {
  description = "Variables of TFCloud organization:"
  type        = map(any)
}

######################## REASONABLE DEFAULT VALUES ########################
variable "organization_name" {
  type        = string
  description = "Nome da organização TFE"
  default     = "pedrosaxu"
}