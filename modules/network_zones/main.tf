resource "okta_network_zone" "network_zone" {
  for_each = { for network_zone in var.network_zones_map.network_zones : network_zone.name => network_zone }

  name                      = each.value.name
  type                      = each.value.type
  dynamic_locations         = try(each.value.dynamic_locations, null)
  dynamic_locations_exclude = try(each.value.dynamic_locations_exclude, null)
  dynamic_proxy_type        = try(each.value.dynamic_proxy_type, null)
  gateways                  = try(each.value.gateways, null)
  proxies                   = try(each.value.proxies, null)
  usage                     = try(each.value.usage, null)
  asns                      = try(each.value.asns, null)
}

resource "okta_threat_insight_settings" "default_threatinsight" {
  action           = "block"
  network_excludes = try([(okta_network_zone.network_zone["${var.threatinsight_network_exclude}"]).id], null)
}