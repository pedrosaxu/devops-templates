variable "name" {
  type        = string
  description = "The name of the repository to create."
}

variable "envs" {
  type        = list(string)
  description = "The name of the envs of the repository to create."
}

variable "client_name" {
  type        = string
  description = "The name of the client of the repository to create."
}

variable "account_name" {
  type        = string
  description = "The name of the account of the repository to create."
}

variable "project_id" {
  type        = string
  description = "The id of the project to create."
}

variable "repository_id" {
  type        = string
  description = "The id of the repository to create."
}



