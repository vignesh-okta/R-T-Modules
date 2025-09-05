# Okta - R&T Terraform Package - Authorization Server

This folder contains all the related files required to create and configure Authorization Servers in Okta.
The module uses the following terraform resources:

1. [okta_auth_server](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server)
2. [okta_auth_server_scope](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_scope)
3. [okta_auth_server_claim](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_claim)
4. [okta_auth_server_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy)
5. [okta_auth_server_policy_rule](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy_rule)


### Description

This module is used to create the authorization servers and define the scopes, claims and access policies tied to the auth server. The file `authorization_server.json` is used to define the requirements for the authorization server. 
