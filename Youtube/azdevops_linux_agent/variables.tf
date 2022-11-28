variable "prefix" {
  type        = string
  description = "The prefix which should be used for all resources in this example"
}

variable "subscriptionID" {
  type        = string
  description = "The subscription ID"
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "username" {
  type        = string
  description = "Username for virtual machine"
}

variable "password" {
  type        = string
  description = "Password for virtual machine"
}

variable "resourcegroupname" {
  type        = string
  description = "Resource group"
  default     = "DevOps-Agents-rg"
}

variable "countofvms" {
  type        = number
  description = "no of agents to be created"
  default     = 1
}