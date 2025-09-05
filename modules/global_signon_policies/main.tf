
data "okta_default_policy" "okta_global_session" {
  type = "OKTA_SIGN_ON"
}
resource "okta_policy_signon" "delegate_to_app_signon_policy" {
  for_each = { for policy in var.global_signon_policies_map.global_signon_policies : policy.name => policy }

  name            = each.value.name
  description     = try(each.value.description, null)
  status          = try(each.value.status, null)
  priority        = try(each.value.priority, null)
  groups_included = try([for group_name in each.value.groups_included : local.group_name_id_map[group_name]], null)
}

resource "okta_policy_rule_signon" "delegate_to_app_signon_policy" {
  for_each = try({ for rule in var.global_signon_policies_map.global_signon_policy_rules : join("-", [rule.name, rule.policy_name]) => rule }, [])

  policy_id          = local.gsp_name_id_map[each.value.policy_name]
  name               = each.value.name
  status             = try(each.value.status, null)
  primary_factor     = try(each.value.primary_factor, null)
  identity_provider  = try(each.value.identity_provider, null)
  session_lifetime   = try(each.value.session_lifetime, null)
  session_idle       = try(each.value.session_idle, null)
  access             = try(each.value.access, null)
  network_connection = try(each.value.network_connection, null)
  network_includes   = try([for networkName in each.value.network_includes : var.networkzone_name_id_map[networkName]], null)
  behaviors          = try([for behavior in each.value.behaviors : local.behavior_name_id_map[behavior]], null)
  mfa_required       = try(each.value.mfa_required, null)
  mfa_prompt = try(each.value.mfa_prompt, null)

}