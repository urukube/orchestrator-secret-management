mock_provider "aws" {}

run "creates_correct_number_of_secrets" {
  command = plan

  variables {
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
  }

  assert {
    condition     = length(aws_secretsmanager_secret.this) == 2
    error_message = "Expected 2 secrets to be created"
  }
}

run "empty_secretlist_creates_no_secrets" {
  command = plan

  variables {
    secretlist = {}
  }

  assert {
    condition     = length(aws_secretsmanager_secret.this) == 0
    error_message = "Expected no secrets when secretlist is empty"
  }
}
