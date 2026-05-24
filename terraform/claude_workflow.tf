locals {
  claude_workflow_repos = toset([
    "dotfiles",
    "notes",
    "tasks",
    "tnkabs-hugo",
  ])
}

resource "github_repository_file" "claude_workflow" {
  for_each   = local.claude_workflow_repos
  repository = each.key
  file       = ".github/workflows/claude.yml"
  content    = file("${path.module}/../.github/workflows/claude.yml")

  commit_message      = "Add Claude Code workflow"
  overwrite_on_create = true
}
