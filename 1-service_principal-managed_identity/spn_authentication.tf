resource "azuread_service_principal_password" "spn_secret" {
  count                = var.use_spn_with_secret ? 1 : 0
  service_principal_id = azuread_service_principal.service_principal.id
  display_name         = var.spn_password.display_name != null ? var.spn_password.display_name : null
}
