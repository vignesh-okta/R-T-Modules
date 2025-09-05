variable "user_custom_schema_properties" {
  description = "A map with User schema properties"
  default     = {}
}

variable "user_type_name_id_map" {
  description = "Map of User Types"
  default     = {}
}

variable "app_name_id_map" {
  
}

locals {
  group_name_id_map = merge(var.user_type_name_id_map, { "default" = "${data.okta_user_type.default_user_type.id}" })
}