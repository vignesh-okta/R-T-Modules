
resource "okta_authenticator" "authenticators" {
  for_each = { for authenticator in var.authenticators_map : authenticator.name => authenticator }

  name     = each.value.name
  key      = each.value.key
  status   = each.value.status
  settings = jsonencode(each.value.settings)

  lifecycle {
    ignore_changes = [settings]
  }
}