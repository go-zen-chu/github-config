# github-config

GitHub configuration managed by terraform

## Setup

1. Generate PAT via github settings
2. Set PAT as `TERRAFORM_GITHUB_PAT` to this repository secret
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
