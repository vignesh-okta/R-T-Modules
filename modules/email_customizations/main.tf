
resource "okta_email_customization" "forgot_password_en_alt" {
  for_each = { for email_customization in var.email_customizations_map.email_customizations : join("-", [email_customization.template_name, email_customization.language]) => email_customization }

  brand_id      = var.brand_id
  template_name = each.value.template_name
  language      = each.value.language
  subject       = each.value.subject
  body          = file("${join("", [var.email_customizations_templates_dir, "/", each.value.template_name, "_", each.value.language, ".html"])}")
  is_default    = each.value.is_default
  # force_is_default = each.value.force_is_default
}