output "resource_set_label_ids_map" {
  value = zipmap([for rset in okta_resource_set.resource_set : rset.label],
  [for rset in okta_resource_set.resource_set : rset.id])
}