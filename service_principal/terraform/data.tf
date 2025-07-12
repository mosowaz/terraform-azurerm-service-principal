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