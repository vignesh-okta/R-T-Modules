output "admin_role_custom_label_ids_map" {
  value = zipmap([for admin_role in okta_admin_role_custom.admin_role_custom : admin_role.label],
  [for admin_role in okta_admin_role_custom.admin_role_custom : admin_role.id])
}