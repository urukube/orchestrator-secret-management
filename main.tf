resource "aws_secretsmanager_secret" "this" {
  for_each = var.secretlist

  name        = each.value.name
  description = each.value.description

  tags = merge(var.tags, {
    ManagedBy  = "orchestrator-secret-management"
    LogicalKey = each.key
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = { for k, v in var.secretlist : k => v if contains(keys(var.secret_values), k) }

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = var.secret_values[each.key]
}
