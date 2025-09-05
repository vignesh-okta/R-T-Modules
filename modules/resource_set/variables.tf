variable "resource_set_map" {
  description = "Resource Set Map."
}

variable "custom_admin_roles_common_data_map" {
  description = "Common data for custom admin roles Map."
}

variable "okta_org_url" {
  description = "Okta Org URL."
}

variable "app_label_id_map" {}

variable "group_name_id_map" {}

locals {
  resources = merge({ for group in keys(var.group_name_id_map) : format("groups-%s", group) => var.group_name_id_map[group] },
  { for app in keys(var.app_label_id_map) : format("apps-%s", app) => var.app_label_id_map[app] })
}

