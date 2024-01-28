# github-config

[![Terraform](https://github.com/go-zen-chu/github-config/actions/workflows/terraform.yaml/badge.svg)](https://github.com/go-zen-chu/github-config/actions/workflows/terraform.yaml)

GitHub configuration managed by terraform

## Setup

1. Generate PAT via github settings
2. Set PAT as `TF_VAR_github_token` to this repository secret
3. Run `Terraform` action

## Run locally

In your .envrc

```bash
export TF_VAR_github_token=xxxxxxxxxx
```

Install terraform command and run below

```bash
terraform plan
```

If you already have your directory, then you might need `terraform import` to make tfstate asis.

```bash
terraform import github_repository.your_repo your_repo
```
