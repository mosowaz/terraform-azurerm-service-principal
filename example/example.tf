module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azurerm-service-principal/tree/main/terraform?ref=v1.4.0"

  resource_group = {
    name     = "service_principal"
    location = "canadacentral"
  }

  use_secret      = true
  use_oidc        = true
  use_certificate = true

  # (Optional) block is required only if use_oidc = true
  federation = {
    azdo_organization_name = "Your_Organization"
    azdo_project_name      = "Project_name"
    azdo_repo_name         = "Repository_name"
    azdo_branch            = "main"
  }

  # (Optional) block is required only if use_certificate = true
  client_certificate = {
    common_name  = "Organization_CN_name"
    organization = "Organiztion_name"
  }

  # (Optional) This is required only if use_certificate = true
  certificate_validity_period_hours = 740 # Number of hours
  app_display_name                  = var.display_name
  description                       = var.description
  use_existing                      = true

  app_role_ids = var.app_role_ids

  iam_roles = ["Contributor", "Role Based Access Control Administrator", "Storage Blob Data Contributor", "Key Vault Administrator"]

  spn_password {
    display_name = "Automation account"
    # password is automatically stored in keyvault
  }

  # (Optional) This is required only if use_secret = true
  spn_secret_name          = "SPN-client-secret"
  spn_client_id_name       = "SPN-client-id"
  spn_tenant_id_name       = "SPN-tenant-id"
  spn_subscription_id_name = "SPN-subscription-id"

  keyvault_name = User_defined_string
}

  