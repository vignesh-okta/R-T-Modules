# Okta - R&T Terraform Package - Authenticators

This folder contains all the related files required to add authenticators in Okta.
The module uses the following terraform resources:

1. [okta_authenticator](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/authenticator)

### Description

This module is used to define all the authenticators required to be added at the org level so that they can be configured for enrollment through authenticator enrolment policies. The authenticators are defined through the `authenticators.json` file. 

> **Note**\
> The constraint requirement for Webauthn to be limited to specific types only needs to be added manually via UI.