data "azuredevops_project" "ado_project" {
    name = "${var.client_name}"
}