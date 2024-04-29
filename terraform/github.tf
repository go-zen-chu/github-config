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
  repositories = {
    "github-config" = {
      description = "GitHub configuration managed by terraform"
      visibility  = "public"
    }
    "tasks" = {
      description  = "My private tasks"
      has_projects = true
    }
  }
  num_repositories = length(local.repositories)
  # TIPS: terraform internally handles with alphabetical order -> 120m, 15m, 30m, 45m, 60m, 90m
  working_time_colors = {
    "15m"  = "fffcdb"
    "30m"  = "d4ecea"
    "45m"  = "ae7a26"
    "60m"  = "0068b7"
    "90m"  = "914487"
    "120m" = "f39800"
  }
  num_working_times = length(local.working_time_colors)
  years = [
    "2023",
    "2024",
  ]
  num_years = length(local.years)
  month_colors = {
    "01" = "c7402c"
    "02" = "5e7db9"
    "03" = "e8abb9"
    "04" = "9ac244"
    "05" = "49a099"
    "06" = "8e4993"
    "07" = "4895d0"
    "08" = "d68838"
    "09" = "3c5929"
    "10" = "e0b73e"
    "11" = "763724"
    "12" = "192983"
  }
  num_months      = length(local.month_colors)
  num_year_months = local.num_years * local.num_months
}

# Repositories
resource "github_repository" "repositories" {
  count       = local.num_repositories
  name        = element(keys(local.repositories), count.index)
  description = local.repositories[element(keys(local.repositories), count.index)]["description"]
  # default visibility to private
  visibility             = lookup(local.repositories[element(keys(local.repositories), count.index)], "visibility", "private")
  has_projects           = lookup(local.repositories[element(keys(local.repositories), count.index)], "has_projects", false)
  has_issues             = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}

# Task time labels definitions
resource "github_issue_label" "working_time_labels" {
  # Seems there is no way to loop over defining multiple resources
  # e.g. 3 repo x 5 labels -> 0, 1, 2, 3, 4 for repo0, 5, 6, 7, 8, 9 for repo1, 10, 11, 12, 13, 14 for repo2
  count      = local.num_repositories * local.num_working_times
  repository = element(keys(local.repositories), floor(count.index / local.num_working_times))
  name       = element(keys(local.working_time_colors), floor(count.index % local.num_working_times))
  color      = local.working_time_colors[element(keys(local.working_time_colors), floor(count.index % local.num_working_times))]
}

# Month labels definitions
resource "github_issue_label" "year_month_definition_labels" {
  # e.g. 2 repos x 2 years x 3 month_colors -> repo0: 0, 1, 2 for 2023, 3, 4, 5 for 2024, repo1: 6, 7, 8 for 2023, 9, 10, 11 for 2024
  count      = local.num_repositories * local.num_year_months
  repository = element(keys(local.repositories), floor(count.index / local.num_year_months))
  name       = "${element(local.years, floor(count.index % local.num_year_months / local.num_months))}/${element(keys(local.month_colors), floor(count.index % local.num_year_months % local.num_months))}"
  color      = local.month_colors[element(keys(local.month_colors), floor(count.index % local.num_year_months % local.num_months))]
}
