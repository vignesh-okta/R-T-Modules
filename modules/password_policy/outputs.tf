output "group_name_id_map" {
  value = zipmap([for policy in okta_policy_password.password_policy : policy.name], [for policy in okta_policy_password.password_policy : policy.id])
}