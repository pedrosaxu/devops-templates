variable "project_id" {
  description = "The ID of the project in which the repository is created."
  type        = string
}

variable "repo_id" {
  description = "The ID of the repository in which the branch policies are created."
  type        = string
}

variable "repo_name" {
  description = "The name of the repository in which the branch policies are created."
  type        = string
}

variable "lock_approval" {
  description = "The lock approval of the branch policies."
  type        = bool
  default     = false
}

variable "buildpipeline_id" {
  description = "The ID of the build pipeline in which the branch policies are created."
  type        = string
  default     = ""
}

variable "branch_name" {
  description = "The name of the branch in which the branch policies are created."
  type        = string
}
