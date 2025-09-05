variable "global_signon_policies_map" {}
variable "group_name_id_map" {}

data "okta_group" "everyone" {
  name = "Everyone"
}

data "okta_group" "oktaAdministrators" {
  name = "Okta Administrators"
}

data "okta_behavior" "new_country" {
  name = "New Country"
}

data "okta_behavior" "new_state" {
  name = "New State"
}

data "okta_behavior" "new_device" {
  name = "New Device"
}

data "okta_behavior" "velocity" {
  name = "Velocity"
}

variable "networkzone_name_id_map" {}

locals {
  gsp_name_id_map      = zipmap([for gsp in okta_policy_signon.delegate_to_app_signon_policy : gsp.name], [for gsp in okta_policy_signon.delegate_to_app_signon_policy : gsp.id])
  group_name_id_map    = merge(var.group_name_id_map, { "Everyone" = "${data.okta_group.everyone.id}", "Okta Administrators" = "${data.okta_group.oktaAdministrators.id}" })
  behavior_name_id_map = { "New Country" = "${data.okta_behavior.new_country.id}", "New State" = "${data.okta_behavior.new_state.id}", "New Device" = "${data.okta_behavior.new_device.id}", "Velocity" = "${data.okta_behavior.velocity.id}" }
}