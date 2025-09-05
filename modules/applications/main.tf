
resource "okta_app_oauth" "applications_oauth" {
  for_each = { for app in var.applications_oauth_map.oauth : join("-", [app.label, app.type]) => app if app.type != "saml"}

  label                      = each.value.label
  type                       = each.value.type
  status                     = try(each.value.status, "ACTIVE")
  grant_types                = each.value.grant_types
  token_endpoint_auth_method = try(each.value.token_endpoint_auth_method, ((each.value.type == "browser") ? "none" : "client_secret_basic"))
  redirect_uris              = each.value.redirect_uris
  post_logout_redirect_uris  = try(each.value.post_logout_redirect_uris, [])
  response_types             = try(each.value.response_types, ["code"])
  implicit_assignment        = try(each.value.implicit_assignment, false)
  refresh_token_leeway       = try(each.value.refresh_token_leeway, (each.value.refresh_token_rotation !=null ? ((each.value.refresh_token_rotation == "ROTATE")? 5 : 0) : null))
  refresh_token_rotation     = try(each.value.refresh_token_rotation, "ROTATE")
  wildcard_redirect          = try(each.value.wildcard_redirect, "DISABLED")
  pkce_required              = try(each.value.pkce_required, true)
  logo                       = can(each.value.logo) ? "${join("", [var.images_dir, "/", each.value.logo])}" : null
  authentication_policy      = var.app_signon_policy_name_id_map[each.value.authentication_policy]
  login_uri                  = try(each.value.login_uri, null)
}


# Create SAML Apps
resource "okta_app_saml" "app_saml" {
  for_each = { for app in var.applications_oauth_map.oauth : join("-", [app.label, app.type]) => app if app.type == "saml" }

  #Required
  label = each.value.label

  #Optional
  accessibility_error_redirect_url = try(each.value.accessibility_error_redirect_url, null)
  accessibility_login_redirect_url = try(each.value.accessibility_login_redirect_url, null)
  accessibility_self_service       = try(each.value.accessibility_self_service, null)
  authentication_policy            = try(var.app_signon_policy_name_id_map[each.value.authentication_policy], null)
  acs_endpoints                    = try(each.value.acs_endpoints, null)
  admin_note                       = try(each.value.admin_note, null)
  app_links_json                   = try(jsonencode(each.value.app_links_json), null)
  app_settings_json                = try(jsonencode(each.value.app_settings_json), null)
  assertion_signed                 = try(each.value.assertion_signed, null)
  audience                         = try(each.value.audience, null)
  authn_context_class_ref          = try(each.value.authn_context_class_ref, null)
  auto_submit_toolbar              = try(each.value.auto_submit_toolbar, null)
  default_relay_state              = try(each.value.default_relay_state, null)
  destination                      = try(each.value.destination, null)
  digest_algorithm                 = try(each.value.digest_algorithm, null)
  enduser_note                     = try(each.value.enduser_note, null)
  hide_ios                         = try(each.value.hide_ios, null)
  hide_web                         = try(each.value.hide_web, null)
  honor_force_authn                = try(each.value.honor_force_authn, null)
  idp_issuer                       = try(each.value.idp_issuer, null)
  implicit_assignment              = try(each.value.implicit_assignment, null)
  key_name                         = try(each.value.key_name, null)
  key_years_valid                  = try(each.value.key_years_valid, null)
  logo                             = can(each.value.logo) ? "${join("", [var.images_dir, "/", each.value.logo])}" : null
  recipient                        = try(each.value.recipient, null)
  request_compressed               = try(each.value.request_compressed, null)
  response_signed                  = try(each.value.response_signed, null)
  saml_version                     = try(each.value.saml_version, null)
  saml_signed_request_enabled      = try(each.value.saml_signed_request_enabled, null)
  signature_algorithm              = try(each.value.signature_algorithm, null)
  single_logout_certificate        = try(each.value.single_logout_certificate, null)
  single_logout_issuer             = try(each.value.single_logout_issuer, null)
  single_logout_url                = try(each.value.single_logout_url, null)
  sp_issuer                        = try(each.value.sp_issuer, null)
  sso_url                          = try(each.value.sso_url, null)
  subject_name_id_format           = try(each.value.subject_name_id_format, null)
  subject_name_id_template         = try(each.value.subject_name_id_template, null)
  user_name_template               = try(each.value.user_name_template, null)
  user_name_template_push_status   = try(each.value.user_name_template_push_status, null)
  user_name_template_suffix        = try(each.value.user_name_template_suffix, null)
  user_name_template_type          = try(each.value.user_name_template_type, null)

  dynamic "attribute_statements" { // Create a attribute_statements property with an array with one json obj with the attribute_statements properties
    for_each = try(each.value.attribute_statements, [])
    content {
      name         = attribute_statements.value.name
      filter_type  = try(attribute_statements.value.filter_type, null)
      filter_value = try(attribute_statements.value.filter_value, null)
      namespace    = try(attribute_statements.value.namespace, null)
      type         = try(attribute_statements.value.type, null)
      values       = try(attribute_statements.value.values, null)
    }
  }
}