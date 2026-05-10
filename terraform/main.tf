terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = "go-zen-chu" # Change me
}

variable "github_token" {
  type = string
}

locals {
  repositories = merge(
    local.task_repos,
  )
}

# Repositories
resource "github_repository" "repositories" {
  for_each    = local.repositories
  name        = each.key
  description = each.value.description
  # default visibility to private
  visibility             = lookup(each.value, "visibility", "private")
  has_projects           = lookup(each.value, "has_projects", false)
  has_issues             = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}
