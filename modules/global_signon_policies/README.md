# Okta - R&T Terraform Package - Global Session Policies

This folder contains all the related files required to create Global Session Policies in Okta.
The module uses the following terraform data sources:

1. [okta_default_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/default_policy)

The module uses the following terraform resources:

1. [okta_policy_signon](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_signon)
2. [okta_policy_rule_signon](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_rule_signon)

### Description

This module is used to create all the global session policies defined in the `global_signon_policies.json` file. The data source is used to fetch the Default policy out of the box and add a rule to deny all login access as the default failover if none of the policies above it are applicable.
