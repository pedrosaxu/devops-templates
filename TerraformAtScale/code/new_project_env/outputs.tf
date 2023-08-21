output "tfe_project_list" {
    value = data.external.tfe_projects_list.result
}

output "lookup_project_id" {
    value = lookup(data.external.tfe_projects_list.result, "${var.client_name}", "not found")
}