# create client secret for authentication
resource "azuread_service_principal_password" "spn_secret" {
  count                = var.use_secret ? 1 : 0
  service_principal_id = azuread_service_principal.service_principal.id
  display_name         = var.spn_password.display_name
}

# create  Open ID Connect (OIDC) for authentication
resource "azuread_application_federated_identity_credential" "spn_oidc" {
  count = var.use_oidc ? 1 : 0

  application_id = azuread_application.spn_application.id
  display_name   = "azuredevops-oidc"
  description    = var.description
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://vstoken.dev.azure.com/${var.federation.azdo_organization_name}"
  subject        = "repo:${var.federation.azdo_project_name}/${var.federation.azdo_repo_name}:ref:refs/heads/${var.federation.azdo_branch}"
}

# RSA key of size 4096 bits 
resource "tls_private_key" "cert_key" {
  count = var.use_certificate ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

# self-signed TLS certificate
resource "tls_self_signed_cert" "signed_cert" {
  count = var.use_certificate ? 1 : 0

  subject {
    common_name  = var.client_certificate.common_name
    organization = var.client_certificate.organization
  }

  private_key_pem       = tls_private_key.cert_key[0].private_key_pem
  validity_period_hours = var.certificate_validity_period_hours
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "timestamping"
  ]
}

# Associates the self-signed (Client) Certificate with the Service Principal
resource "azuread_service_principal_certificate" "spn_certificate" {
  count = var.use_certificate ? 1 : 0

  service_principal_id = azuread_service_principal.service_principal.id
  type                 = "AsymmetricX509Cert"
  value                = tls_self_signed_cert.signed_cert[0].cert_pem
  end_date             = tls_self_signed_cert.signed_cert[0].validity_end_time
  start_date           = tls_self_signed_cert.signed_cert[0].validity_start_time

  lifecycle {
    ignore_changes = [start_date, end_date]
  }
}