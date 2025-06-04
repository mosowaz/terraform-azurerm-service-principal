module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

###### Module starts here #######
module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azuredevops-modules/tree/main/service_principal?ref=v1.3.0"


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

  my_publicIP = "10.10.20.20"

  spn_secret_name          = "SPN-client-secret"
  spn_client_id_name       = "SPN-client-id"
  spn_tenant_id_name       = "SPN-tenant-id"
  spn_subscription_id_name = "SPN-subscription-id"
}

  