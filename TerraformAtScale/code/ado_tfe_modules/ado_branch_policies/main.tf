terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

resource "azuredevops_branch_policy_min_reviewers" "account_branch_policy_review" {

  project_id = var.project_id

  enabled  = true
  blocking = true

  settings {
    submitter_can_vote = true
    reviewer_count     = 1

    scope {
      repository_id  = var.repo_id
      repository_ref = var.branch_name
      match_type     = "Exact"
    }
  }
}


resource "azuredevops_branch_policy_auto_reviewers" "devops_group_approval" {
  project_id = var.project_id

  enabled  = true
  blocking = var.lock_approval

  settings {
    auto_reviewer_ids  = [data.azuredevops_group.devops_group.origin_id]
    message            = "Devops admins auto review"

    scope {
      repository_id  = var.repo_id
      repository_ref = var.branch_name
      match_type     = "Exact"
    }
  }
}


resource "azuredevops_branch_policy_build_validation" "account_branch_policy_build" {

  count = var.buildpipeline_id == "" ? 0 : 1

  project_id = var.project_id
  enabled    = true
  blocking   = true

  settings {
    display_name        = var.repo_name
    build_definition_id = var.buildpipeline_id
    valid_duration      = 720

    scope {
      repository_id  = var.repo_id
      repository_ref = var.branch_name
      match_type     = "Exact"
    }

  }

}
