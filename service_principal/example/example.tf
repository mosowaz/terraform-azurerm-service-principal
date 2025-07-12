module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azuredevops-modules/tree/main/service_principal/terraform?ref=v1.3.0"

  resource_group = {
    name     = "service_principal"
    location = "canadacentral"
  }

  use_secret      = true
  use_oidc        = true
  use_certificate = true

  federation = {
    azdo_organization_name = "Your_Organization"
    azdo_project_name      = "Project_name"
    azdo_repo_name         = "Repository_name"
    azdo_branch            = "main"
  }

  client_certificate = {
    common_name  = "Organization_CN_name"
    organization = "Organiztion_name"
  }

  certificate_validity_period_hours = 740
  app_display_name                  = var.display_name
  description                       = var.description
  use_existing                      = true

  app_role_ids = var.app_role_ids

  iam_roles = ["Contributor", "Role Based Access Control Administrator", "Storage Blob Data Contributor", "Key Vault Administrator"]

  spn_password {
    display_name = "Automation account"
  }
  
  spn_secret_name          = "SPN-client-secret"
  spn_client_id_name       = "SPN-client-id"
  spn_tenant_id_name       = "SPN-tenant-id"
  spn_subscription_id_name = "SPN-subscription-id"

  keyvault_name            = User_defined_string
  storage_account_name     = User_defined_string
  storage_container_name   = User_defined_string
}

  