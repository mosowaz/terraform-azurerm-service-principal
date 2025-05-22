# Get current IP address for use in KV firewall rules
data "http" "ip" {
  url = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afae"
}

module "avm-res-keyvault-vault" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-keyvault-vault.git?ref=6e49111ba5"

  name                          = "SPN-KeyVault-${module.naming.key_vault.name_unique}"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  tenant_id                     = azuread_service_principal.service_principal.application_tenant_id
  public_network_access_enabled = true
  secrets = {
    secret = {
      name = "SPN-client-secret"
    }
    client-id = {
      name = "SPN-client-id"
    }
    tenant-id = {
      name = "SPN-tenant-id"
    }
    subscription-id = {
      name = "SPN-subscription-id"
    }
  }
  secrets_value = {
    secret          = azuread_service_principal_password.spn_secret[0].value
    client-id       = azuread_application.spn_application.client_id
    tenant-id       = azuread_service_principal.service_principal.application_tenant_id
    subscription-id = data.azurerm_subscription.primary.subscription_id
  }
  network_acls = {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["${data.http.ip.response_body}/32"]
  }
}
