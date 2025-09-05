resource "okta_group_rule" "group_rule" {
  for_each          = { for grouprule in var.group_rules_map : grouprule.name => grouprule }
  name              = each.value.name
  status            = "ACTIVE"
  group_assignments = [for group_name in each.value.group_assignments : var.group_name_id_map[group_name]]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = each.value.expression_value
}