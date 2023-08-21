output "workspace_id" {
  description = "Workspace id of TFCloud organization:"
  value       = tfe_workspace.workspace.id
}
  
output "workspace_name" {
  description = "Workspace name of TFCloud organization:"
  value       = tfe_workspace.workspace.name
}

