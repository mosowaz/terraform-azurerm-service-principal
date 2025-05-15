variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Name and location of resource group"
}

variable "use_spn_with_secret" {
  type        = bool
  description = "should service principal with secret be used"
}

variable "use_spn_with_oidc" {
  type        = bool
  description = "Should service principal with OIDC be used"
}

variable "use_msi" {
  type        = bool
  description = "Should managed identity be used"
}

variable "app_display_name" {
  type        = string
  default     = "spn_with_secret"
  description = "The display name of the application associated with this service principal."
}

variable "description" {
  default     = "Service principal for automation"
  description = "Description of the SPN being created"
}

variable "use_existing" {
  default     = true
  description = <<-DESCRIPTION
    When true, any existing service principal linked to the same application will be automatically imported. 
    When false, an import error will be raised for any pre-existing service principal.
  DESCRIPTION
}

variable "app_role_ids" {
  type        = list(string)
  description = <<-DESCRIPTION
    API permission for required by the service principal running "terraform apply"
    "Application.ReadWrite.All"
    "Directory.ReadWrite.All"
  DESCRIPTION
}