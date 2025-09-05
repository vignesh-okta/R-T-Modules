# Okta - R&T Terraform Package - Authenticator Enrolment Policies

This folder contains all the related files required to create Authenticator Enrolment Policies in Okta.
The module uses the following terraform data sources:

1. [okta_default_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/default_policy)

The module uses the following terraform resources:

1. [okta_policy_mfa](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_mfa)
2. [okta_policy_rule_mfa](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_rule_mfa)

### Description

This module is used to create all the authenticator enrolment policies defined in the `authenticators_enroll_policies.json` file. It defines the allowed authenticators at a group level through the policies and also includes logic to update the rule for the Default policy that is available out of the box.

> **Note**\
> The WebAuthn authenticator group has to be manually configured in the UI after running terraform
