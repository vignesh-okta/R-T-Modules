resource "okta_resource_set" "resource_set" {
  for_each = { for resource_set in var.resource_set_map : resource_set.label => resource_set }

  label       = each.value.label
  description = each.value.description

  #https://<domain>/api/v1/groups/<group-id>/users
  resources = try([for resource in each.value.resources
    : format("%s%s%s", var.okta_org_url,resource.type=="group"||resource.type=="users_in_group"?"/api/v1/groups/":resource.type=="user"?"/api/v1/users/":resource.type=="app"?"/api/v1/apps/":"",format("%s%s",try(local.resources[format("%s-%s",resource.type=="users_in_group"?"group":resource.type,resource.name)],""),resource.type=="users_in_group"?"/users":""))
  ], null)
}