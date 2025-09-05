
output "group-rule_name_id_map" {
  value = zipmap([for group_rule in okta_group_rule.group_rule : group_rule.name], [for group_rule in okta_group_rule.group_rule : group_rule.id])
}