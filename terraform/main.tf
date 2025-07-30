resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

# Grant "owner" role to current user/sevice principal for the resource group
resource "azurerm_role_assignment" "owner" {
  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.owner_role.name
  principal_id                     = data.azurerm_client_config.current.object_id
  skip_service_principal_aad_check = false
}