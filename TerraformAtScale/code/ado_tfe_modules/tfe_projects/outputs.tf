output "project_id" {
  description = "Project id of TFCloud organization:"
  value       = tfe_project.project.id
}

output "project_name" {
  description = "Project name of TFCloud organization:"
  value       = tfe_project.project.name
}