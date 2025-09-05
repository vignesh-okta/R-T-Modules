# Okta - R&T Terraform Package - Okta Custom Schema Properties

This folder contains all the related files required to create identity providers in Okta.
The module uses the following terraform resources:

1. [okta_user_schema_property](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user_schema_property)

### Description

This module is used to create all the custom attributes required on a user profile in Okta as defined in the `user_custom_schema_properties.json` file. Examples of custom user profile attrbutes include `adDN` and `Terms & Conditions`. This is used to extend the default okta base schema which consists of 31 base attributes and provides us the flexibility to define the type and properties of a custom attribute.
