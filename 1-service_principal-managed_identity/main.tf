terraform {
  backend "azurerm" {
  }
}

data "azuread_client_config" "current" {}

# Needed to get the object_id of current SPN
data "azuread_service_principal" "spn" {
  display_name = "SPN-ADO-2"
}

# Use the role definition data source to get the id of the Owner role
data "azurerm_role_definition" "owner_role" {
  name = "Owner"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_role_assignment" "owner" {
  for_each = toset([data.azurerm_client_config.current.object_id,
  data.azuread_service_principal.spn.object_id])

  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.owner_role.name
  principal_id                     = try(each.value, data.azurerm_client_config.current.object_id)
  skip_service_principal_aad_check = false
}