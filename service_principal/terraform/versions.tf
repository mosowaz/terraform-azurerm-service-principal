terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.3.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.28.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.5"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    virtual_machine {
      detach_implicit_data_disk_on_deletion = true
      delete_os_disk_on_deletion            = true
      skip_shutdown_and_force_delete        = true
    }
    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = false
    }
    key_vault {
    recover_soft_deleted_key_vaults = true
    }
  }
  storage_use_azuread = true
}

