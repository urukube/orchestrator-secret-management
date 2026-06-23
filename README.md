# orchestrator-secret-management

Terraform module that bulk-provisions AWS Secrets Manager secrets for the urukube orchestrator platform.

Pass a map of secrets via `secretlist`; the module creates one `aws_secretsmanager_secret` per entry. Secrets are created empty — values are populated out-of-band (manually, via ESO push, or a rotation Lambda).

## Usage

```hcl
module "secrets" {
  source = "git::https://github.com/urukube/orchestrator-secret-management.git?ref=v1.0.0"

  secretlist = {
    github_token = {
      name        = "platform/github/token"
      description = "GitHub PAT for ArgoCD SCM provider"
    }
    argocd_admin = {
      name        = "platform/argocd/admin-password"
      description = "ArgoCD admin password"
    }
  }

  tags = { env = "prod" }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_secret_values"></a> [secret\_values](#input\_secret\_values) | Map of logical key → secret value. Injected via TF\_VAR\_secret\_values in CI; never stored in tfvars files. | `map(string)` | `{}` | no |
| <a name="input_secretlist"></a> [secretlist](#input\_secretlist) | Map of secrets to create in AWS Secrets Manager.<br/>Key   = stable logical identifier used by Terraform (e.g. "github\_token").<br/>Value = object with the actual SM path and an optional description.<br/><br/>Example (in orchestrator.tfvars):<br/>  secretlist = {<br/>    github\_token = {<br/>      name        = "platform/github/token"<br/>      description = "GitHub PAT used by ArgoCD SCM provider"<br/>    }<br/>    argocd\_admin = {<br/>      name        = "platform/argocd/admin-password"<br/>      description = "ArgoCD admin password"<br/>    }<br/>  } | <pre>map(object({<br/>    name        = string<br/>    description = optional(string, "")<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to every secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | Map of logical key → secret ARN |
| <a name="output_secret_names"></a> [secret\_names](#output\_secret\_names) | Map of logical key → secret name (SM path) |
<!-- END_TF_DOCS -->
