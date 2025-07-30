data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}

# Use the role definition data source to get the id of the Owner role
data "azurerm_role_definition" "owner_role" {
  name = "Owner"
}