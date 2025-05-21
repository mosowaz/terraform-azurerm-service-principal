variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Name and location of resource group"
}

variable "use_spn_with_secret" {
  type        = bool
  description = "Should the Service Principal be used to authenticate with Client Secret?"
}

variable "use_spn_with_oidc" {
  type        = bool
  description = "Should the Service Principal be used to authenticate with OpenID Connect?"
}

variable "use_spn_with_certificate" {
  type        = bool
  description = "Should the Service Principal be used to authenticate with Client Certificate?"
}

variable "use_msi" {
  type        = bool
  description = "Should Managed Identity be used for authentication?"
}

variable "app_display_name" {
  type        = string
  default     = "My_Automation_Account"
  description = "The display name of the application associated with this service principal."
}

variable "description" {
  default     = "Service principal for automation"
  description = "Description of the SPN being created"
}

variable "use_existing" {
  type        = bool
  description = <<-DESCRIPTION
    When true, any existing service principal linked to the same application will be automatically imported. 
    When false, an import error will be raised for any pre-existing service principal.
  DESCRIPTION
}

variable "app_role_ids" {
  type        = list(string)
  description = "API permissions required by the service principal running terraform apply"
}

variable "iam_roles" {
  type        = list(string)
  description = "IAM roles required for the Service Principal to perform operations"
}

variable "spn_password" {
  type = object({
    display_name = string
    start_date   = optional(any, null)
    end_date     = optional(any, null)
  })
  description = "List of object references to the Service Principal password"
}