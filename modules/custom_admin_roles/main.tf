resource "okta_resource_set" "resource_set" {
  for_each = { for resource_set in local.resource_set_map : resource_set.label => resource_set }

  label       = each.value.label
  description = each.value.description

  resources = try([for resource in each.value.resources
    : format("%s%s%s", local.okta_org_url,resource.type=="group"||resource.type=="users_in_group"?"/api/v1/groups/":resource.type=="user"?"/api/v1/users/":resource.type=="app"?"/api/v1/apps":"",format("%s%s",try(local.resources_map[format("%s-%s",resource.type=="users_in_group"?"group":resource.type,resource.name)],""),resource.type=="users_in_group"?"/users":""))
  ], null)
  }

resource "okta_admin_role_custom" "admin_role_custom" {
  for_each = { for admin_role_custom in local.admin_role_custom_map : admin_role_custom.label => admin_role_custom }

  label       = each.value.label
  description = each.value.description
  permissions = try(each.value.permissions, null)
  depends_on = [ okta_resource_set.resource_set ]
}

