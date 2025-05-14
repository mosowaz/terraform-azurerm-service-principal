resource "azuread_application" "spn_application" {
  display_name = var.app_display_name
  owners       = [data.azuread_client_config.current.object_id, data.azuread_service_principal.spn.object_id]
}

resource "azuread_service_principal" "spn_with_secret" {
  for_each = toset([data.azurerm_client_config.current.object_id,
  data.azuread_service_principal.spn.object_id])

  client_id                    = azuread_application.spn_application.client_id
  app_role_assignment_required = true
  owners                       = try(each.value, [data.azurerm_client_config.current.object_id])
  description = var.description
  use_existing = var.use_existing
}