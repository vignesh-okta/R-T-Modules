variable "app_signon_policy_map" {
  description = "app signon policies Map"
  default     = {}
}

variable "networkzone_name_id_map" {
  description = "Network Zone Name-ID Map"
  default     = {}
}

variable "group_name_id_map" {
  description = "Groups Name-ID Map"
  default     = {}
}

locals {
  ordered_policy_rule_set = toset(sort([for rule in var.app_signon_policy_map.app_signon_policy_rules : format("%03d-%s-%s", rule.priority, rule.policy_name, rule.name)]))
  policy_rule_map         = { for rule in var.app_signon_policy_map.app_signon_policy_rules : format("%03d-%s-%s", rule.priority, rule.policy_name, rule.name) => rule }
  policy_name_id_map      = zipmap([for policy in okta_app_signon_policy.app_signon_policy : policy.name], [for policy in okta_app_signon_policy.app_signon_policy : policy.id])
}