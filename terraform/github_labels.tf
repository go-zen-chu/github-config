
locals {
  task_repos = {
    "tasks" = {
      description  = "My private tasks"
      has_projects = true
    }
  }
  # TIPS: terraform internally handles with alphabetical order -> 120m, 15m, 30m, 45m, 60m, 90m
  working_time_colors = {
    "15m"  = "fffcdb"
    "30m"  = "d4ecea"
    "45m"  = "ae7a26"
    "60m"  = "0068b7"
    "90m"  = "914487"
    "120m" = "f39800"
  }
  flatten_repository_working_time_colors = flatten([
    for repo, value in local.task_repos : [
      for time, color in local.working_time_colors : {
        repository = repo
        time       = time
        color      = color
      }
    ]
  ])
  years = [
    "2023",
    "2024",
    "2025",
    "2026",
  ]
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
  flatten_year_month_colors = flatten([
    for year in local.years : [
      for month, color in local.month_colors : {
        year_month = "${year}/${month}"
        color      = color
      }
    ]
  ])
  flatten_repository_year_month_colors = flatten([
    # only set for task_repos those require year_month
    for repo in ["tasks"] : [
      for f in local.flatten_year_month_colors : {
        repository = repo
        year_month = f.year_month
        color      = f.color
      }
    ]
  ])
}

# Task time labels definitions
resource "github_issue_label" "working_time_labels" {
  # no nested for_each in terraform
  for_each = {
    for f in local.flatten_repository_working_time_colors : "${f.repository}-${f.time}" => f
  }
  repository = each.value.repository
  name       = each.value.time
  color      = each.value.color
}

# Month labels definitions
resource "github_issue_label" "year_month_definition_labels" {
  for_each = {
    for f in local.flatten_repository_year_month_colors : "${f.repository}-${f.year_month}" => f
  }
  repository = each.value.repository
  name       = each.value.year_month
  color      = each.value.color
}
