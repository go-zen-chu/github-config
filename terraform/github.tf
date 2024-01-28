terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
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
variable "repositories" {
  type = list(string)
  # repositories that you want to manage by this configs
  default = [
    "github-config",
  ]
}
variable "time_colors" {
  type = map(string)
  default = {
    "15m"  = "fffcdb"
    "30m"  = "d4ecea"
    "45m"  = "ae7a26"
    "60m"  = "0068b7"
    "90m"  = "914487"
    "120m" = "f39800"
  }
}
variable "month_colors" {
  type = map(string)
  default = {
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
}

# Repositories
resource "github_repository" "github-config" {
  name        = "github-config"
  description = "GitHub configuration managed by terraform"
}

# Task time labels definitions
resource "github_issue_label" "label-15m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "15m"
  color       = var.time_colors["15m"]
  description = "Task that takes 15 minutes"
}
resource "github_issue_label" "label-30m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "30m"
  color       = var.time_colors["30m"]
  description = "Task that takes 30 minutes"
}
resource "github_issue_label" "label-45m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "45m"
  color       = var.time_colors["45m"]
  description = "Task that takes 45 minutes"
}
resource "github_issue_label" "label-60m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "60m"
  color       = var.time_colors["60m"]
  description = "Task that takes 60 minutes"
}
resource "github_issue_label" "label-90m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "90m"
  color       = var.time_colors["90m"]
  description = "Task that takes 90 minutes"
}
resource "github_issue_label" "label-120m" {
  for_each    = toset(var.repositories)
  repository  = each.value
  name        = "120m"
  color       = var.time_colors["120m"]
  description = "Task that takes 120 minutes"
}

# Month labels definitions
resource "github_issue_label" "label-2023-09" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2023/09"
  color      = var.month_colors["09"]
}
resource "github_issue_label" "label-2023-10" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2023/10"
  color      = var.month_colors["10"]
}
resource "github_issue_label" "label-2023-11" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2023/11"
  color      = var.month_colors["11"]
}
resource "github_issue_label" "label-2023-12" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2023/12"
  color      = var.month_colors["12"]
}
resource "github_issue_label" "label-2024-01" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/01"
  color      = var.month_colors["01"]
}
resource "github_issue_label" "label-2024-02" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/02"
  color      = var.month_colors["02"]
}
resource "github_issue_label" "label-2024-03" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/03"
  color      = var.month_colors["03"]
}
resource "github_issue_label" "label-2024-04" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/04"
  color      = var.month_colors["04"]
}
resource "github_issue_label" "label-2024-05" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/05"
  color      = var.month_colors["05"]
}
resource "github_issue_label" "label-2024-06" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/06"
  color      = var.month_colors["06"]
}
resource "github_issue_label" "label-2024-07" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/07"
  color      = var.month_colors["07"]
}
resource "github_issue_label" "label-2024-08" {
  for_each   = toset(var.repositories)
  repository = each.value
  name       = "2024/08"
  color      = var.month_colors["08"]
}

