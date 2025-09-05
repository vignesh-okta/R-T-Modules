# Okta - R&T Terraform Package - Authentication Policies

This folder contains all the related files required to create authentication polices for apps in Okta.
The module uses the following terraform data sources:

1. [okta_app](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/app)
2. [okta_app_signon_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/app_signon_policy)

The module uses the following terraform resources:

1. [okta_app_signon_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_signon_policy)
2. [okta_app_signon_policy_rule](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_signon_policy_rule)

### Description

This module is used to create all the application specific authentication policies defined in the `app_signon_policies.json` file. It uses a couple data sources to fetch the policies for the out of the box applications: Okta Admin Console and Okta Dashboard. For all the custom apps that are created, the resources are used to create a policy and define the corresponding rules tied to the policy.

