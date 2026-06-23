################################################################################
# AWS Secrets Manager — bulk secret provisioning
#
# Creates one secret per entry in var.secretlist.
# Secrets are created empty (no initial value); values are populated out-of-band
# (manually, via ESO push, or a separate rotation Lambda).
################################################################################

resource "aws_secretsmanager_secret" "this" {
  for_each = var.secretlist

  name        = each.value.name
  description = each.value.description

  tags = merge(var.tags, {
    ManagedBy     = "orchestrator-secret-management"
    LogicalKey    = each.key
  })
}
