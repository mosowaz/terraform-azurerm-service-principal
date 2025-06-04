variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = "service_principal_and_identity"
    location = "canadacentral"
  }
  description = "(Optional) Name and location of resource group"
}

variable "use_secret" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with Client Secret?"
}

variable "use_oidc" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with OpenID Connect?"
}

<<<<<<<< HEAD:terraform/variables.tf
variable "use_certificate" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with Client Certificate?"
}

========
>>>>>>>> 8632c12 (fix: modify variable names, and update example.tf):service_principal/variables.tf
variable "federation" {
  type = object({
    azdo_organization_name = optional(string, null)
    azdo_project_name      = optional(string, null)
    azdo_repo_name         = optional(string, null)
    azdo_branch            = optional(string, "*")
  })
  default     = {}
  description = <<-DESCRIPTION
    (Optional) This block is required if use_oidc = true
    This assumes you already have a repository and a project in your organization.
  DESCRIPTION

  validation {
    condition = (
      var.use_oidc == false ||
      (
        var.federation.azdo_organization_name != null && var.federation.azdo_organization_name != "" &&
        var.federation.azdo_project_name != null && var.federation.azdo_project_name != "" &&
        var.federation.azdo_repo_name != null && var.federation.azdo_repo_name != ""
      )
    )
    error_message = "If use_oidc is true, then azdo_organization_name, azdo_project_name, and azdo_repo_name must all be non-null and non-empty."
  }
}

variable "certificate_validity_period_hours" {
  type        = number
<<<<<<<< HEAD:terraform/variables.tf
  default     = null
  description = "(Optional) Number of hours the client certificate will be valid for. This is required if use_certificate = true"

  validation {
    condition = (
      var.use_certificate == false ||
      (var.certificate_validity_period_hours != null && var.certificate_validity_period_hours > 0)
    )
    error_message = "If use_certificate is true, then certificate_validity_period_hours must be non-null and positive number."
  }
}

========
  default     = 1440
  description = "(Optional) Number of days the client certificate will be valid for. This is required if use_certificate = true"
}

variable "use_certificate" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with Client Certificate?"
}

>>>>>>>> 8632c12 (fix: modify variable names, and update example.tf):service_principal/variables.tf
variable "client_certificate" {
  type = object({
    common_name  = optional(string, null)
    organization = optional(string, null)
  })
  default     = {}
  description = <<-DESCRIPTION
    (Optional) This block is required if use_certificate = true
    common_name: Distinguished name (e.g myapp.example.com). organization: Distinguished name (i.e YOUR_ORGANIZATION_NAME)
  DESCRIPTION

  validation {
    condition     = var.use_certificate == false || (var.client_certificate != null && var.client_certificate != "")
    error_message = "If use_certificate is true, then client_certificate must be non-null and non-empty."
  }
}

variable "app_display_name" {
  type        = string
  default     = "My_Automation_Account"
  description = "(Optional) The display name of the application associated with this service principal."
}

variable "description" {
  type        = string
  default     = "Service principal for automation"
  description = "(Optional) Description of the Service Principal being created"
}

variable "use_existing" {
  type        = bool
  description = <<-DESCRIPTION
    (Required) When true, any existing service principal linked to the same application will be automatically imported. 
    When false, an import error will be raised for any pre-existing service principal.
  DESCRIPTION
}

variable "app_role_ids" {
  type        = list(string)
  description = "(Required) API permissions required by the service principal running terraform apply"
}

variable "iam_roles" {
  type        = list(string)
  description = "(Required) IAM roles required for the Service Principal to perform operations"
}

variable "spn_password" {
  type = object({
    display_name = optional(string, null)
    start_date   = optional(any, null)
    end_date     = optional(any, null)
  })
  default     = {}
  description = "(Optional) Object references to the Service Principal password"
<<<<<<<< HEAD:terraform/variables.tf

  validation {
    condition = (
      var.use_secret == false || (var.spn_password != null && var.spn_password != "")
    )
    error_message = "If use_secret is true, then spn_password must be non-null and non-empty."
  }
========
>>>>>>>> 8632c12 (fix: modify variable names, and update example.tf):service_principal/variables.tf
}

variable "my_publicIP" {
  type        = string
  sensitive   = true
<<<<<<<< HEAD:terraform/variables.tf
  description = "(Required) public/private IP address to allow access to Key Vault and Storage account"
========
  description = "(Required) List of public/private IP addresses to allow access to Key Vault and Storage account"
>>>>>>>> 8632c12 (fix: modify variable names, and update example.tf):service_principal/variables.tf
}

variable "keyvault_name" {
  type        = string
  description = "(Required) Name of the Key Vault"
}

variable "spn_secret_name" {
  type        = string
  default     = "spn_secret_name"
  description = "(Optional) Name given to the service principal's secret value. Required if use_secret = true"

  validation {
    condition = (
      var.use_secret == false || (var.spn_secret_name != null && var.spn_secret_name != "")
    )
    error_message = "If use_secret is true, then spn_secret_name must be non-null and non-empty."
  }
}

variable "spn_client_id_name" {
  type        = string
  default     = "spn_client_id"
  description = "(Optional) Name given to the service principal's client ID. Required if use_secret = true"

  validation {
    condition = (
      var.use_secret == false || (var.spn_client_id_name != null && var.spn_client_id_name != "")
    )
    error_message = "If use_secret is true, then spn_client_id_name must be non-null and non-empty."
  }
}

variable "spn_tenant_id_name" {
  type        = string
  description = "(Required) Name given to the service principal's tenant ID"
}

variable "spn_subscription_id_name" {
  type        = string
  description = "(Required) Name given to the service principal's subscription ID"
}

variable "create_storage_account" {
  type        = bool
  default     = true
  description = "(Optional) Should storage account be created for storing terraform states"
}
variable "storage_account_name" {
  type        = string
  default     = "tfstate"
  description = "(Optional) Name of the storage account created for the SPN"
}

variable "storage_container_name" {
  type        = string
  default     = "tfstates-container"
  description = "(Optional) Name of the storage container created for the SPN"
}