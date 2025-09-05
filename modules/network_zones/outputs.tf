output "networkzones_name_id_map" {
  value = zipmap([for networkzone in okta_network_zone.network_zone : networkzone.name], [for networkzone in okta_network_zone.network_zone : networkzone.id])
}