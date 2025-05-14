resource "azuread_application" "spn_application" {
  display_name = var.app_display_name
  owners       = [data.azuread_client_config.current.object_id, data.azuread_service_principal.spn.object_id]
}

resource "azuread_directory_role" "app_admin" {
  display_name = "Application administrator"
}

resource "azuread_directory_role_assignment" "role_assign" {
  role_id             = azuread_directory_role.app_admin.object_id
  principal_object_id = data.azuread_service_principal.spn.object_id
}

resource "azuread_service_principal" "spn_with_secret" {
  for_each = toset([data.azuread_client_config.current.object_id,
  data.azuread_service_principal.spn.object_id])

  client_id                    = azuread_application.spn_application.client_id
  app_role_assignment_required = true
  owners                       = [each.value]
  description                  = var.description
  use_existing                 = var.use_existing
}