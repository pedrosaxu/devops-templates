variable "project_name" {
    type        = string
    description = "The name of the Terraform Cloud project:"
}

######################## REASONABLE DEFAULT VALUES ########################

variable "organization_name" {
    type        = string
    description = "The name of the Terraform Cloud organization:"
    default     = "pedrosaxu"
}
