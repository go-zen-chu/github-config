# github-config

[![Terraform](https://github.com/go-zen-chu/github-config/actions/workflows/terraform.yaml/badge.svg)](https://github.com/go-zen-chu/github-config/actions/workflows/terraform.yaml)

GitHub configuration managed by terraform

## Setup

1. Generate PAT via github settings. You can use an action's GITHUB_TOKEN which is used default but it has limited permissions.
2. Set PAT as `TF_VAR_github_token` to this repository secret
3. Run `Terraform` action

## Run locally

In your .envrc

```bash
# create PAT as shown in Setup
export TF_VAR_github_token=xxxxxxxxxx
```

Install terraform command and run below

```bash
cd ./terraform
terraform init -upgrade
terraform plan
```

If you already have your directory, then you might need `terraform import` to make tfstate asis.

```bash
terraform import 'github_repository.repositories[0]' your_repo
```

## Troubleshooting

### When you want to change `count` to `for_each`

You can use `state mv` command.

```console
$ terraform state mv 'github_repository.repositories[1]' 'github_repository.repositories["tasks"]'       
Move "github_repository.repositories[1]" to "github_repository.repositories[\"tasks\"]"
Successfully moved 1 object(s).
```
