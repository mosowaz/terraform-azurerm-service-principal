variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "(Required) Name and location of resource group"
}

variable "use_secret" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with Client Secret?"
}

variable "use_oidc" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with OpenID Connect?"
}

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
}

variable "certificate_validity_period_hours" {
  type        = number
  default     = 1440
  description = "(Optional) Number of days the client certificate will be valid for. This is required if use_certificate = true"
}

variable "use_certificate" {
  type        = bool
  description = "(Required) Should the Service Principal be used to authenticate with Client Certificate?"
}

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
}

variable "my_publicIP" {
  type        = string
  sensitive   = true
  description = "(Required) public/private IP address to allow access to Key Vault and Storage account"
}

variable "keyvault_name" {
  type        = string
  description = "(Required) Name of the Key Vault"
}

variable "spn_secret_name" {
  type        = string
  default     = "spn_secret_name"
  description = "(Optional) Name given to the service principal's secret value. Required if use_secret = true"
}

variable "spn_client_id_name" {
  type        = string
  default     = "spn_client_id"
  description = "(Optional) Name given to the service principal's client ID. Required if use_secret = true"
}

variable "spn_tenant_id_name" {
  type        = string
  description = "(Required) Name given to the service principal's tenant ID"
}

variable "spn_subscription_id_name" {
  type        = string
  description = "(Required) Name given to the service principal's subscription ID"
}

variable "storage_account_name" {
  type        = string
  description = "(Required) Name of the storage account created for the SPN"
}

variable "storage_container_name" {
  type        = string
  description = "(Required) Name of the storage container created for the SPN"
}