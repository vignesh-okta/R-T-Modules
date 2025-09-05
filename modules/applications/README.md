# Okta - R&T Terraform Package - Applications

This folder contains all the related files required to create applications in Okta.
The module uses the following terraform resources:

1. [okta_app_oauth](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth)
2. [okta_app_saml](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml)


### Description

This module is used to create all the OIDC and SAML applications defined in the applications folder of input_files. Each app will have it's own JSON payload with individual files. SAML app details have to be retrieved manually from the Okta Admin console. Below are sample payloads for an OIDC app and SAML app:

**OIDC Application**

```
{
  "label": "R&T Standard Login App",
  "type": "web",
  "grant_types": ["authorization_code", "interaction_code", "refresh_token"],
  "redirect_uris": [
    "http://localhost:8080/authorization-code/callback",
    "http://localhost:8080/login/callback"
  ],
  "post_logout_redirect_uris": ["http://localhost:8080"],
  "trusted_origins_cors": ["http://localhost:5001"],
  "response_types": ["code"],
  "pkce_required": false,
  "consent_method": "REQUIRED",
  "refresh_token_rotation": "STATIC",
  "implicit_assignment": true,
  "authentication_policy": "R&T Authentication Policy",
  "login_uri": "https://app.R&Tgov.com/auth/login"
}
```

**SAML Application**

```
{
  "label": "Custom_SAML_App",
  "type": "saml",
  "sso_url": "https://yourdomain.com/sso/saml",
  "recipient": "https://yourdomain.com/sso/saml",
  "destination": "https://yourdomain.com/sso/saml",
  "audience": "https://domain.com",
  "subject_name_id_template": "$${user.userName}",
  "subject_name_id_format": "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent",
  "response_signed": true,
  "signature_algorithm": "RSA_SHA256",
  "digest_algorithm": "SHA256",
  "honor_force_authn": false,
  "authn_context_class_ref": "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
  "implicit_assignment": true,
  "attribute_statements": [{
    "type": "EXPRESSION",
    "name": "User.Email",
    "namespace": "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified",
    "values": ["user.email"]
  },
  {
    "type": "EXPRESSION",
    "name": "User.Username",
    "namespace": "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified",
    "values": ["user.email"]
  },
  {
    "type": "EXPRESSION",
    "name": "first_name",
    "namespace": "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified",
    "values": ["user.firstName"]
  },
  {
    "type": "EXPRESSION",
    "name": "last_name",
    "namespace": "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified",
    "values": ["user.lastName"]
  }
]
}
```
