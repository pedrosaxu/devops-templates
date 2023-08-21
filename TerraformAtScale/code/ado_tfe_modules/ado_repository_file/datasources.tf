data "template_file" "envs_paths" {
  for_each = toset(var.envs)

  template = file("${path.module}/git_file_templates/env/main.tf")

  vars = {
    client_name = var.client_name
    account_name = var.account_name
    env = each.value
  }

}