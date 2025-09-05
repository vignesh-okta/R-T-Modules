
data "okta_default_policy" "default_enroll_policy" {
  type = "MFA_ENROLL"
}


resource "okta_policy_mfa" "authenticator_enroll_policies" {
  for_each = { for aep in var.authenticator_enroll_policies_map.authenticator_custom_enrollment_policies : aep.name => aep }

  name        = each.value.name
  description = each.value.description
  status      = each.value.status
  is_oie      = each.value.is_oie
  priority    = each.value.priority

  okta_password = {
    enroll = try(each.value.okta_password.enroll, null)
  }

  okta_email = {
    enroll = try(each.value.okta_email.enroll, null)
  }

    okta_verify = {
    enroll = try(each.value.okta_verify.enroll, null)
  }

  webauthn = {
    enroll = try(each.value.webauthn.enroll, null)
    
  }


  groups_included = [for group_name in each.value.groups_included : local.group_name_id_map[group_name]]

}

resource "okta_policy_rule_mfa" "mfa_enroll_policy_rule" {
  for_each = { for aepr in var.authenticator_enroll_policies_map.authenticator_custom_enrollment_policy_rules : join("-", [aepr.name, aepr.policy_name]) => aepr }

  policy_id = each.value.policy_name == "Default Policy" ? data.okta_default_policy.default_enroll_policy.id:local.aep_name_id_map[each.value.policy_name]
  name      = each.value.name
  status    = each.value.status
  enroll    = each.value.enroll
  priority  = each.value.priority
  network_connection = each.value.network_connection
  network_includes = try([for networkName in each.value.network_includes : var.networkzone_name_id_map[networkName]], null)
  users_excluded = []
}
