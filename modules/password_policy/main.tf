data "okta_default_policy" "default_policy" {
  type = "PASSWORD"
}

resource "okta_policy_password" "password_policy" {
  for_each = { for policy in var.password_policy_map.policies : policy.name => policy }

  # Required Attributes
  name = each.value.name

  # Optional Attributes
  description = try(each.value.description, null)
  # priority                               = try(each.value.priority, null)
  status                                 = try(each.value.status, null)
  groups_included                        = try([for group_name in each.value.groups_included : var.groups_name_id_map[group_name]], null)
  auth_provider                          = try(each.value.auth_provider, null)
  password_max_age_days                  = try(each.value.password_max_age_days, null)
  password_max_lockout_attempts          = try(each.value.password_max_lockout_attempts, null)
  password_min_length                    = try(each.value.password_min_length, null)
  password_min_symbol                    = try(each.value.password_min_symbol, null)
  password_min_lowercase                 = try(each.value.password_min_lowercase, null)
  password_min_number                    = try(each.value.password_min_number, null)
  password_min_uppercase                 = try(each.value.password_min_uppercase, null)
  password_min_age_minutes               = try(each.value.password_min_age_minutes, null)
  password_exclude_username              = try(each.value.password_exclude_username, null)
  password_exclude_first_name            = try(each.value.password_exclude_first_name, null)
  password_exclude_last_name             = try(each.value.password_exclude_last_name, null)
  password_dictionary_lookup             = try(each.value.password_dictionary_lookup, null)
  password_expire_warn_days              = try(each.value.password_expire_warn_days, null)
  password_history_count                 = try(each.value.password_history_count, null)
  password_auto_unlock_minutes           = try(each.value.password_auto_unlock_minutes, null)
  password_show_lockout_failures         = try(each.value.password_show_lockout_failures, null)
  password_lockout_notification_channels = try(each.value.password_lockout_notification_channels, null)
  recovery_email_token                   = try(each.value.recovery_email_token, null)
  question_recovery                      = "INACTIVE"
  email_recovery                         = try(each.value.email_recovery, null)
  sms_recovery                           = try(each.value.sms_recovery, null)
  call_recovery                          = try(each.value.call_recovery, null)
  skip_unlock                            = try(each.value.skip_unlock, null)
}


resource "okta_policy_rule_password" "password_policy_rule" {
  for_each = { for rule in var.password_policy_map.rules : format("%s-%s", rule.policy_name, rule.name) => rule }

  # Required Attributes
  policy_id = local.pwdpolicy_name_id_map[each.value.policy_name]
  name      = each.value.name

  # Optional Attributes
  # priority                               = try(each.value.priority, null)
  status             = try(each.value.status, null)
  password_change    = try(each.value.password_change, null)
  password_reset     = try(each.value.password_reset, null)
  password_unlock    = try(each.value.password_unlock, null)
  network_connection = try(each.value.network_connection, null)
  network_includes   = try([for networkName in each.value.network_includes : var.networkzone_name_id_map[networkName]], null)
  network_excludes   = try([for networkName in each.value.network_excludes : var.networkzone_name_id_map[networkName]], null)

  depends_on = [
    okta_policy_password.password_policy
  ]
}
