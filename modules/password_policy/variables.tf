variable "password_policy_map" {
  description = "Map of Password Policies"
}

variable "groups_name_id_map" {
  description = "Map of Group Names and IDs"
  default     = {}
}

variable "networkzone_name_id_map" {
  description = "Network Zone Name-ID Map"
  default     = {}
}


locals {
  pwdpolicy_name_id_map = merge(zipmap([for pwdpolicy in okta_policy_password.password_policy : pwdpolicy.name],
  [for pwdpolicy in okta_policy_password.password_policy : pwdpolicy.id]),{"Default Policy": "${data.okta_default_policy.default_policy.id}"})
  pwdpolicy_id_name_map = merge(zipmap([for pwdpolicy in okta_policy_password.password_policy : pwdpolicy.name],
  [for pwdpolicy in okta_policy_password.password_policy : pwdpolicy.id]),{"Default Policy": "${data.okta_default_policy.default_policy.id}"})
}
