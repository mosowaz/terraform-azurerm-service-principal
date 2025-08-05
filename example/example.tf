module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azurerm-service-principal.git//terraform?ref=v1.5.0"

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

  app_role_ids = ["bf7b1a76-6e77-406b-b258-bf5c7720e98f",] # (Optional) API permission (Group.Create)

  iam_roles = ["Contributor",] # List of roles for SPN
  # default scope is resource group

  spn_password = {
    display_name = "Automation account"
  }
}

  