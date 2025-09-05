data "okta_user_type" "default_user_type" {
  name = "user"
}

resource "okta_user_schema_property" "user_schema_property" {
  for_each = { for property in var.user_custom_schema_properties : property.index => property }

  #Required
  index = each.value.index
  title = each.value.title
  type  = each.value.type

  #Optional
  array_type  = try(each.value.array_type, null)
  description = try(each.value.description, null)
  required    = try(each.value.required, null)
  master      = try(each.value.master, null)
  min_length  = try(each.value.min_length, null)
  max_length  = try(each.value.max_length, null)
  permissions = try(each.value.permissions, null)
  scope       = try(each.value.scope, null)
  unique      = try(each.value.unique, null)

  dynamic "master_override_priority" {
    for_each = try(each.value.master_override_priority, [])
    content {
      value = each.value.master=="OVERRIDE"?var.app_name_id_map[master_override_priority.value]: null
    }
  }

  enum = try([for enum_key in each.value.enum : enum_key.const], null)
  dynamic "one_of" {
    for_each = try(each.value.enum, [])
    content {
      title = one_of.value.title
      const = one_of.value.const
    }
  }

  array_enum = try([for enum_key in each.value.array_enum : enum_key.const], null)
  dynamic "array_one_of" {
    for_each = try(each.value.array_enum, [])
    content {
      title = array_one_of.value.title
      const = array_one_of.value.const
    }
  }

  # user_type = try(local.group_name_id_map[each.value.user_type], "default")

  lifecycle {
    ignore_changes  = [id, unique]
    prevent_destroy = false
  }

}