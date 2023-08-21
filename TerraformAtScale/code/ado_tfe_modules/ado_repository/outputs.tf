output "repository_name" {
  value = azuredevops_git_repository.account_repository.name
}

output "repository_id" {
  value = azuredevops_git_repository.account_repository.id
}

output "repository_url" {
  value = azuredevops_git_repository.account_repository.remote_url
}

output "repository_default_branch" {
  value = azuredevops_git_repository.account_repository.default_branch
}
  