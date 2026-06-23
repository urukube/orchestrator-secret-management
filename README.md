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
<!-- END_TF_DOCS -->
