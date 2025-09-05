resource "okta_auth_server" "azs_rnt" {
  for_each = { for authZ_server in var.okta_auth_server_map.servers : authZ_server.name => authZ_server }

  name                      = each.value.name
  description               = each.value.description
  audiences                 = each.value.audiences
  issuer_mode               = each.value.issuer_mode
  status                    = each.value.status
  credentials_rotation_mode = each.value.credentials_rotation_mode
}

resource "okta_auth_server_scope" "azs_rnt_scopes" {
  for_each = { for az_scopes in var.okta_auth_server_map.scopes : join("-", [az_scopes.name, az_scopes.auth_server_name]) => az_scopes }

  name             = each.value.name
  display_name     = each.value.display_name
  description      = each.value.description
  auth_server_id   = local.az_name_id_map[each.value.auth_server_name]
  metadata_publish = each.value.metadata_publish
  consent          = each.value.consent
  default          = each.value.default

  depends_on = [
    okta_auth_server.azs_rnt
  ]
}

resource "okta_auth_server_claim" "azs_rnt_claims" {
  for_each = { for az_claims in var.okta_auth_server_map.claims : join("-", [az_claims.name, az_claims.auth_server_name]) => az_claims }

  name                    = each.value.name
  value_type              = each.value.value_type
  value                   = each.value.value
  claim_type              = each.value.claim_type
  scopes                  = each.value.scopes
  auth_server_id          = local.az_name_id_map[each.value.auth_server_name]
  always_include_in_token = try(each.value.always_include_in_token, "true")
  status                  = try(each.value.status, "ACTIVE")
  group_filter_type       = each.value.group_filter_type

  depends_on = [
    okta_auth_server_scope.azs_rnt_scopes
  ]
}

resource "okta_auth_server_policy" "azs_rnt_policy" {
  for_each = { for az_accessPolicy in var.okta_auth_server_map.accessPolicies : join("-", [az_accessPolicy.name, az_accessPolicy.auth_server_name]) => az_accessPolicy }

  name             = each.value.name
  description      = each.value.description
  status           = each.value.status
  priority         = each.value.priority
  auth_server_id   = local.az_name_id_map[each.value.auth_server_name]
  client_whitelist = [for app_name in each.value.client_whitelist : local.app_names_ids_map[app_name]]
}

resource "okta_auth_server_policy_rule" "azs_rnt_policy_rule" {
  for_each = { for az_accessPolicyRule in var.okta_auth_server_map.accessPoliciesRules : join("-", [az_accessPolicyRule.name, az_accessPolicyRule.policy_name, az_accessPolicyRule.auth_server_name]) => az_accessPolicyRule }

  name            = each.value.name
  policy_id       = local.azp_name_id_map[join("-", [each.value.policy_name, local.az_name_id_map[each.value.auth_server_name]])]
  auth_server_id  = local.az_name_id_map[each.value.auth_server_name]
  status          = each.value.status
  priority        = each.value.priority
  scope_whitelist = each.value.scope_whitelist
  group_whitelist = ["EVERYONE"]
  # group_whitelist = [for group_name in each.value.group_whitelist : local.group_names_ids_map[group_name]]
  # group_blacklist = try([for group_name in each.value.group_blacklist : local.group_names_ids_map[group_name]],[])
  grant_type_whitelist = each.value.grant_type_whitelist
}

