output "app_name_id_map" {
  value = merge(zipmap([for app in okta_app_oauth.applications_oauth : app.label], [for app in okta_app_oauth.applications_oauth : app.id]),zipmap([for app in okta_app_saml.app_saml : app.label], [for app in okta_app_saml.app_saml : app.id]))
}