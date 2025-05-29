module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azuredevops-modules/tree/main/1-service_principal-managed_identity?ref=v1.0.0"

  use_spn_with_secret = true
  use_spn_with_oidc = false
  use_spn_with_certificate = false
  use_msi = false
}