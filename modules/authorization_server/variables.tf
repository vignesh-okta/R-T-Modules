variable "okta_auth_server_map" {}

variable "app_names_ids_map" {}

locals {
  az_name_id_map = zipmap(
    [for az in okta_auth_server.azs_rnt : az.name],
    [for az in okta_auth_server.azs_rnt : az.id]
  )
  az_id_name_map = zipmap(
    [for az in okta_auth_server.azs_rnt : az.id],
    [for az in okta_auth_server.azs_rnt : az.name]
  )
  azp_name_id_map = zipmap(
    [for azp in okta_auth_server_policy.azs_rnt_policy : join("-", [azp.name, azp.auth_server_id])],
    [for azp in okta_auth_server_policy.azs_rnt_policy : azp.id]
  )
  app_names_ids_map = merge(var.app_names_ids_map, { "ALL_CLIENTS" = "ALL_CLIENTS" })
}