resource "aws_secretsmanager_secret" "this" {
  # checkov:skip=CKV_AWS_149: AWS-managed encryption is sufficient for platform secrets in Phase 1; CMK to be added in Phase 3 security hardening
  # checkov:skip=CKV2_AWS_57: Static platform tokens managed by the platform team; rotation Lambda is out of scope for Phase 1
  for_each = var.secretlist

  name                    = each.value.name
  description             = each.value.description
  recovery_window_in_days = 0

  tags = merge(var.tags, {
    ManagedBy  = "orchestrator-secret-management"
    LogicalKey = each.key
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = { for k, v in var.secretlist : k => v if contains(nonsensitive(keys(var.secret_values)), k) }

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = var.secret_values[each.key]

  lifecycle {
    ignore_changes = [secret_string]
  }
}
