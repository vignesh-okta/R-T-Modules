resource "okta_group" "groups" {
  for_each = { for group in var.groups_map : group.name => group }

  name        = each.value.name
  description = try(each.value.description, null)
}