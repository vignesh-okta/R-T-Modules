output "app_signon_policy_name_id_map" {
  value = zipmap([for policy in okta_app_signon_policy.app_signon_policy : policy.name], [for policy in okta_app_signon_policy.app_signon_policy : policy.id])
}

output "sorted_rule_names_set" {
  value = local.ordered_policy_rule_set
}