terraform {
  backend "azurerm" {
  }
}

data "azuread_user" "primary_owner" {
  object_id = "92ce5dc7-39b3-4609-ad99-11b862d33bbd"
}

data "azurerm_subscription" "primary" {}

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

# Grant "owner" role to current user/sevice principal for the resource group
resource "azurerm_role_assignment" "owner" {
  for_each = toset([data.azuread_user.primary_owner.object_id,
  data.azuread_service_principal.spn.object_id])

  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.owner_role.name
  principal_id                     = each.value
  skip_service_principal_aad_check = false
}