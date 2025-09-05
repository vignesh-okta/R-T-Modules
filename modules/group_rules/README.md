# Okta - R&T Terraform Package - Group Rules

This folder contains all the related files required to create group rules in Okta.
The module uses the following terraform resources:

1. [okta_group_rule](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_rule)

### Description

This module is used to create group rules defined in the `group-rules.json` file. It uses the expression provided in the JSON file to define the condition to add the user automatically to the necessary groups.
