resource "azuread_service_principal_password" "spn_secret" {
  count                = var.use_secret ? 1 : 0
  service_principal_id = azuread_service_principal.service_principal.id
  display_name         = var.spn_password.display_name != null ? var.spn_password.display_name : null
}

resource "azuread_application_federated_identity_credential" "spn_azuredevops_oidc" {
  count = var.use_oidc.enabled ? 1 : 0

  application_id = azuread_application.spn_application.id
  display_name   = "azuredevops-oidc"
  description    = "SPN with OIDC for AzureDevops"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://vstoken.dev.azure.com/${var.use_oidc.azdo_organization_name}"
  subject        = "repo:${var.use_oidc.azdo_project_name}/${var.use_oidc.azdo_repo_name}:ref:refs/heads/${var.use_oidc.azdo_branch}"
}