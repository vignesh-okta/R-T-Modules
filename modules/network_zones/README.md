# Okta - R&T Terraform Package - Network Zones

This folder contains all the related files required to create network zones in Okta.
The module uses the following terraform resources:

1. [okta_network_zone](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/etwork_zone)

### Description

This module is used to create network zones defined in the `network_zones.json` file. The defined network zones can then be referenced in all the policies by name.

Country codes and region codes for dynamic zones can be reference below:

- [Country Codes for locations](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
- [Country with Region Codes](https://en.wikipedia.org/wiki/ISO_3166-2)
