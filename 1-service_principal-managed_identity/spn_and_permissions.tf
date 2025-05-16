resource "azuread_application" "spn_application" {
  display_name = var.app_display_name
  owners       = [data.azuread_client_config.current.object_id, data.azuread_service_principal.spn.object_id]
}

resource "azuread_service_principal" "service_principal" {
  client_id                    = azuread_application.spn_application.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id, data.azuread_service_principal.spn.object_id]
  description                  = var.description
  use_existing                 = var.use_existing
}

# Azure Active Directory role permissions required for service principal
resource "azuread_directory_role" "directory_roles" {
  for_each     = toset(["Application administrator", "Azure DevOps Administrator", "Directory Writers", "Directory Readers"])
  display_name = each.value
}

resource "azuread_directory_role_assignment" "dir_role_assign" {
  for_each            = azuread_directory_role.directory_roles
  role_id             = each.value.template_id
  principal_object_id = data.azuread_service_principal.spn.object_id
}

# Assign IAM roles to Service Principal
resource "azurerm_role_assignment" "iam_roles" {
  for_each = toset(var.iam_roles)

  scope                = try(data.azurerm_subscription.primary.id, azurerm_resource_group.rg)
  role_definition_name = each.value
  principal_id         = azuread_service_principal.service_principal.object_id
}

# Use to retrieve Microsoft Graph cliend_id
data "azuread_service_principal" "msgraph_api" {
  display_name = "Microsoft Graph"
}

# API permissions for the Service Principal
resource "azuread_application_api_access" "api_permission" {
  application_id = azuread_application.spn_application.id
  api_client_id  = data.azuread_service_principal.msgraph_api.client_id  # "00000003-0000-0000-c000-000000000000" 
  role_ids       = var.app_role_ids
}

