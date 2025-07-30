resource "azuread_application" "spn_application" {
  display_name = var.app_display_name
  owners       = try([data.azurerm_client_config.current.object_id], "")
}

resource "azuread_service_principal" "service_principal" {
  client_id                    = azuread_application.spn_application.client_id
  app_role_assignment_required = true
  owners                       = try([data.azurerm_client_config.current.object_id], "")
  description                  = try(var.description, null)
  use_existing                 = try(var.use_existing, false)
}

# Assign IAM roles to Service Principal
resource "azurerm_role_assignment" "iam_roles" {
  for_each = toset(var.iam_roles)

  scope                = azurerm_resource_group.rg.id
  role_definition_name = each.value
  principal_id         = azuread_service_principal.service_principal.object_id
}

resource "azurerm_role_assignment" "iam_roles_user" {
  for_each = toset(var.iam_roles)

  scope                = azurerm_resource_group.rg.id
  role_definition_name = each.value
  principal_id         = data.azurerm_client_config.current.object_id
}

# Use to retrieve Microsoft Graph cliend_id
data "azuread_service_principal" "msgraph_api" {
  display_name = "Microsoft Graph"
}

# API permissions for the Service Principal
resource "azuread_application_api_access" "api_permission" {
  application_id = azuread_application.spn_application.id
  api_client_id  = data.azuread_service_principal.msgraph_api.client_id # "00000003-0000-0000-c000-000000000000" 
  role_ids       = var.app_role_ids
}

