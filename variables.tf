variable "secretlist" {
  description = <<-EOT
    Map of secrets to create in AWS Secrets Manager.
    Key   = stable logical identifier used by Terraform (e.g. "github_token").
    Value = object with the actual SM path and an optional description.

    Example (in orchestrator.tfvars):
      secretlist = {
        github_token = {
          name        = "platform/github/token"
          description = "GitHub PAT used by ArgoCD SCM provider"
        }
        argocd_admin = {
          name        = "platform/argocd/admin-password"
          description = "ArgoCD admin password"
        }
      }
  EOT

  type = map(object({
    name        = string
    description = optional(string, "")
  }))
  default = {}
}

variable "secret_values" {
  description = "Map of logical key → secret value. Injected via TF_VAR_secret_values in CI; never stored in tfvars files."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "tags" {
  description = "Tags applied to every secret"
  type        = map(string)
  default     = {}
}
