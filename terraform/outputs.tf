output "service_principal_id" {
  value = azuread_service_principal.service_principal.id
}

output "service_principal_object_id" {
  value = azuread_service_principal.service_principal.object_id
}

output "service_principal_secret_value" {
  value     = azuread_service_principal_password.spn_secret[0].value
  sensitive = true
}

output "application_id" {
  value = azuread_application.spn_application.id
}

# Application's object ID
output "application_object_id" {
  value = azuread_application.spn_application.object_id
}

# Client ID for the application
output "application_client_id" {
  value = azuread_application.spn_application.client_id
}

# client certificate
output "spn_client_cert" {
  value     = tls_self_signed_cert.signed_cert[0].cert_pem
  sensitive = true
}

output "end_date" {
  value = azuread_service_principal_certificate.spn_certificate[0].end_date
}

output "start_date" {
  value = azuread_service_principal_certificate.spn_certificate[0].start_date
}

output "tls_self_signed_cert" {
  value     = tls_self_signed_cert.signed_cert[0].cert_pem
  sensitive = true
}