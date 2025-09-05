data "okta_app" "admin_console" {
  label = "Okta Admin Console"
}

data "okta_app" "okta_dashboard" {
  label = "Okta Dashboard"
}

data "okta_app_signon_policy" "admin_policy" {
  app_id = data.okta_app.admin_console.id
}

data "okta_app_signon_policy" "dashboard_policy" {
  app_id = data.okta_app.okta_dashboard.id
}


resource "okta_app_signon_policy" "app_signon_policy" {
  for_each = { for policy in var.app_signon_policy_map.app_signon_policies : policy.name => policy }

  name        = each.value.name
  description = each.value.description
}

resource "okta_app_signon_policy_rule" "app_signon_policy_rule" {
  for_each = { for rule in var.app_signon_policy_map.app_signon_policy_rules : format("%03d-%s-%s", rule.priority, rule.name, rule.policy_name) => rule }

  #Required Attributes
  name      = each.value.name
  policy_id = each.value.policy_name=="Okta Admin Console"? data.okta_app_signon_policy.admin_policy.id : each.value.policy_name=="Okta Dashboard" ?data.okta_app_signon_policy.dashboard_policy.id:local.policy_name_id_map[each.value.policy_name]

  #Optional Attributes
  status                      = try(each.value.status, null)
  access                      = try(each.value.access, null)
  custom_expression           = try(each.value.custom_expression, null)
  factor_mode                 = try(each.value.factor_mode, null)
  inactivity_period           = try(each.value.inactivity_period, null)
  re_authentication_frequency = try(each.value.re_authentication_frequency, null)
  constraints                 = try([for constraint in each.value.constraints : jsonencode(constraint)], null)
  type                        = try(each.value.type, null)
  priority                    = try(each.value.priority, null)

  #Network
  network_connection = try(each.value.network_connection, null)
  network_includes   = try([for networkName in each.value.network_includes : var.networkzone_name_id_map[networkName]], null)
  network_excludes   = try([for networkName in each.value.network_excludes : var.networkzone_name_id_map[networkName]], null)

  #Users : Must be list of IDs
  user_types_included = try(each.value.user_types_included, null)
  user_types_excluded = try(each.value.user_types_excluded, null)
  users_included      = try(each.value.users_included, null)
  users_excluded      = try(each.value.users_excluded, null)

  #Platform
  dynamic "platform_include" {
    for_each = try(each.value.platform_include, [])
    content {
      type    = platform_include.value.type
      os_type = platform_include.value.os_type
    }
  }

  #Groups
  groups_included = try([for groupName in each.value.groups_included : var.group_name_id_map[groupName]], null)
  groups_excluded = try([for groupName in each.value.groups_excluded : var.group_name_id_map[groupName]], null)

}

