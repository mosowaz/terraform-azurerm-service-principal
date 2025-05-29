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
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afae"
}

module "avm-res-keyvault-vault" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-keyvault-vault.git?ref=6e49111ba5"

  name                          = "${var.keyvault_name}-${module.naming.key_vault.name_unique}"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  tenant_id                     = azuread_service_principal.service_principal.application_tenant_id
  public_network_access_enabled = true
  secrets = {
    secret = {
      name = var.spn_secret_name
    }
    client-id = {
      name = var.spn_client_id_name
    }
    tenant-id = {
      name = var.spn_tenant_id_name
    }
    subscription-id = {
      name = var.spn_subscription_id_name
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
    ip_rules       = [var.my_publicIP]
    # ip_rules       = ["${data.http.ip.response_body}/24"]
  }
}

module "avm-res-storage-storageaccount" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount?ref=daf3cad"

  location                 = azurerm_resource_group.rg.location
  name                     = "${var.storage_account_name}${module.naming.storage_account.name_unique}"
  resource_group_name      = azurerm_resource_group.rg.name
  account_kind             = "StorageV2"
  account_replication_type = "ZRS"
  account_tier             = "Standard"
  azure_files_authentication = {
    default_share_level_permission = "StorageFileDataSmbShareContributor"
    directory_type                 = "AADKERB"
  }
  blob_properties = {
    versioning_enabled = true
  }
  containers = {
    blob_container0 = {
      name          = var.storage_container_name
      public_access = "None"
    }
  }
  queues = {
  }
  shares = {
  }
  https_traffic_only_enabled = true
  managed_identities = {
    system_assigned = true
  }
  min_tls_version = "TLS1_2"
  network_rules = {
    bypass         = ["AzureServices"]
    default_action = "Deny"
    ip_rules       = [var.my_publicIP]
    # ip_rules       = ["${data.http.ip.response_body}/24"]
  }
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  shared_access_key_enabled       = false
}
