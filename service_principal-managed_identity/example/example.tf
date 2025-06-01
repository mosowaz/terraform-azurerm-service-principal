module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azuredevops-modules/tree/main/service_principal-managed_identity?ref=v1.0.0"

  use_secret      = true
  use_oidc        = false
  use_certificate = false
  use_msi         = false
}