variable "authenticator_enroll_policies_map" {
  description = "Map of authenticators enrollment policies"
}

variable "group_name_id_map" {}

data "okta_group" "everyone" {
  name = "Everyone"
}

data "okta_group" "oktaAdministrators" {
  name = "Okta Administrators"
}

variable "networkzone_name_id_map" {
  description = "Network Zone Name-ID Map"
  default     = {}
}

locals {
  aep_name_id_map   = zipmap([for aep in okta_policy_mfa.authenticator_enroll_policies : aep.name], [for aep in okta_policy_mfa.authenticator_enroll_policies : aep.id])
  group_name_id_map = merge(var.group_name_id_map, { "Everyone" = "${data.okta_group.everyone.id}", "Okta Administrators" = "${data.okta_group.oktaAdministrators.id}" })
}
