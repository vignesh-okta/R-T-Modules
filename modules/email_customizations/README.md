# Okta - R&T Terraform Package - Email Customizations

This folder contains all the related files required to customize the email templates in Okta.
The module uses the following terraform resources:

1. [okta_email_customization](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/email_customization)

### Description

This module is used to create all the customized email templates for multile languages defined in the `email_customizations.json` file. The JSON needs to include all the templates and languages to be populated. The HTML for each of the templates should be created in the `email_custom_templates` folder with the naming convention of `TemplateName_language`. Below is a sample template for the JSON:

```
{
  "email_customizations": [
    {
      "template_name": "EmailChallenge",
      "language": "en",
      "is_default": true,
      "subject": "Email Challenge",
      "force_is_default": "create,delete"
    }
  ]
}
```

The corresponding HTML file should be named as **EmailChallenge_en.html**
