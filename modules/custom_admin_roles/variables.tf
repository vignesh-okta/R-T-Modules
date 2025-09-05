variable "admin_roles_map" {
  description = "Admin Roles Map."
}

variable "app_label_id_map" {}

variable "OKTA_BASE_URL" {}

variable "OKTA_ORG_NAME" {}

variable "group_name_id_map" {}



locals {
  resources_map = merge({ for group in keys(var.group_name_id_map) : format("group-%s", group) => var.group_name_id_map[group] },
  { for app in keys(var.app_label_id_map) : format("app-%s", app) => var.app_label_id_map[app] })
  resource_set_map =  var.admin_roles_map["resource_set"]
  admin_role_custom_map = var.admin_roles_map["admin_roles"]
  okta_org_url = format("https://%s.%s", var.OKTA_ORG_NAME,var.OKTA_BASE_URL)
  builtin_admin_roles = ["APP_ADMIN","ORG_ADMIN","API_ACCESS_MANAGEMENT_ADMIN","GROUP_MEMBERSHIP_ADMIN","HELP_DESK_ADMIN","REPORT_ADMIN","READ_ONLY_ADMIN","SUPER_ADMIN","USER_ADMIN"]
}