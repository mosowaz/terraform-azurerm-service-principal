resource_group = {
    name     = "service_principal"
    location = "canadacentral"
  }

use_secret      = true
use_oidc        = true
use_certificate = true

federation = {
  azdo_organization_name = "MosesOwaseye"
  azdo_project_name      = "hub and spokes vnet peering"
  azdo_repo_name         = "hub and spokes vnet peering"
}

client_certificate = {
  common_name  = "Mosesowaseyegmail.onmicrosoft.com"
  organization = "Moses Owaseye"
}

use_existing = true

app_role_ids = ["1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9", # Application.ReadWrite.All
  "19dbc75e-c2e2-444c-a770-ec69d8559fc7",               # Directory.ReadWrite.All
  "dbb9058a-0e50-45d7-ae91-66909b5d4664",               # Domain.Read.All
  "62a82d76-70ea-41e2-9197-370581804d09",               # Group.ReadWrite.All
"741f803b-c850-494e-b5df-cde7c675a1ca"]                 # User.ReadWrite.All

iam_roles = ["Contributor",
  "Role Based Access Control Administrator",
  "Storage Blob Data Contributor",
"Key Vault Administrator"]

spn_password = {
  display_name = "My Automation Account Password"
}

keyvault_name            = "SPN"
spn_secret_name          = "SPN-client-secret"
spn_client_id_name       = "SPN-client-id"
spn_tenant_id_name       = "SPN-tenant-id"
spn_subscription_id_name = "SPN-subscription-id"

storage_account_name   = "tfstate"
storage_container_name = "tfstates-container"
