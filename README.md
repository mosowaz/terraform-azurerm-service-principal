<!-- BEGIN_TF_DOCS -->
[![Build Status](https://dev.azure.com/MosesOwaseye/Service%20Principal/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Service%20Principal/_build/latest?definitionId=39&branchName=main)

# Terraform Azure Service Principal Module
This module creates Service Principal (with client secrets, OIDC, or client certificate).\
This module also creates Azure Key Vault to store Service Principal secret value and its related attributes,\
 as well as storage account for terraform states used by the Service Principal.

Set one or more of the service principal input variable to "true" to use for authentication.

```hcl
use_secret      = false
use_oidc        = true
use_certificate = false
```
## Note
The user principal assigning the API permissions to the newly provisioned Service Principal must have a `Global Administrator` role\
or `Application.ReadWrite.All` and `Directory.ReadWrite.All` API permission assigned to a Service Principal to successfully assign those permissions for newly created Service Principals.\
Then, go to the portal to explicitly grant `admin consent` to the Service Principal.

### Complete Example - Service Principal with all methods
This example shows how to use the module to create spn with client secret, client certificate, and OIDC by setting their variables to `true`

```hcl
module "service-principal" {
  source = "git::https://github.com/mosowaz/terraform-azurerm-service-principal.git//terraform?ref=v1.4.0"

  resource_group = {
    name     = "service_principal"
    location = "canadacentral"
  }

  use_secret      = true
  use_oidc        = true
  use_certificate = true

  # (Optional) block is required only if use_oidc = true
  federation = {
    azdo_organization_name = "Your_Organization"
    azdo_project_name      = "Project_name"
    azdo_repo_name         = "Repository_name"
    azdo_branch            = "main"
  }

  # (Optional) block is required only if use_certificate = true
  client_certificate = {
    common_name  = "Organization_CN_name"
    organization = "Organiztion_name"
  }

  # (Optional) This is required only if use_certificate = true
  certificate_validity_period_hours = 740 # Number of hours
  app_display_name                  = var.display_name
  description                       = var.description
  use_existing                      = true

  app_role_ids = var.app_role_ids

  iam_roles = ["Contributor", "Role Based Access Control Administrator", "Storage Blob Data Contributor", "Key Vault Administrator"]

  spn_password = {
    display_name = "Automation account"
    # password is automatically stored in keyvault
  }

  # (Optional) This is required only if use_secret = true
  spn_secret_name          = "SPN-client-secret"
  spn_client_id_name       = "SPN-client-id"
  spn_tenant_id_name       = "SPN-tenant-id"
  spn_subscription_id_name = "SPN-subscription-id"

  keyvault_name = User_defined_string
}

  
``` 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.28.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm-res-keyvault-vault"></a> [avm-res-keyvault-vault](#module\_avm-res-keyvault-vault) | git::https://github.com/Azure/terraform-azurerm-avm-res-keyvault-vault.git | 6e49111ba5 |
| <a name="module_avm-res-storage-storageaccount"></a> [avm-res-storage-storageaccount](#module\_avm-res-storage-storageaccount) | git::https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount | daf3cad |
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.com/Azure/terraform-azurerm-naming.git | 75d5afae |

## Resources

| Name | Type |
|------|------|
| [azuread_application.spn_application](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_api_access.api_permission](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) | resource |
| [azuread_application_federated_identity_credential.spn_oidc](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_certificate.spn_certificate](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_certificate) | resource |
| [azuread_service_principal_password.spn_secret](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.iam_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.cert_key](https://registry.terraform.io/providers/hashicorp/tls/4.1.0/docs/resources/private_key) | resource |
| [tls_self_signed_cert.signed_cert](https://registry.terraform.io/providers/hashicorp/tls/4.1.0/docs/resources/self_signed_cert) | resource |
| [azuread_service_principal.msgraph_api](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.spn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.primary_owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_role_definition.owner_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_role_ids"></a> [app\_role\_ids](#input\_app\_role\_ids) | (Required) API permissions required by the service principal running terraform apply | `list(string)` | n/a | yes |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | (Required) IAM roles required for the Service Principal to perform operations | `list(string)` | n/a | yes |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | (Required) Name of the Key Vault | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) Name and location of resource group | <pre>object({<br/>    name     = string<br/>    location = string<br/>  })</pre> | n/a | yes |
| <a name="input_spn_subscription_id_name"></a> [spn\_subscription\_id\_name](#input\_spn\_subscription\_id\_name) | (Required) Name given to the service principal's subscription ID | `string` | n/a | yes |
| <a name="input_spn_tenant_id_name"></a> [spn\_tenant\_id\_name](#input\_spn\_tenant\_id\_name) | (Required) Name given to the service principal's tenant ID | `string` | n/a | yes |
| <a name="input_use_certificate"></a> [use\_certificate](#input\_use\_certificate) | (Required) Should the Service Principal be used to authenticate with Client Certificate? | `bool` | n/a | yes |
| <a name="input_use_existing"></a> [use\_existing](#input\_use\_existing) | (Required) When true, any existing service principal linked to the same application will be automatically imported. <br/>When false, an import error will be raised for any pre-existing service principal. | `bool` | n/a | yes |
| <a name="input_use_oidc"></a> [use\_oidc](#input\_use\_oidc) | (Required) Should the Service Principal be used to authenticate with OpenID Connect? | `bool` | n/a | yes |
| <a name="input_use_secret"></a> [use\_secret](#input\_use\_secret) | (Required) Should the Service Principal be used to authenticate with Client Secret? | `bool` | n/a | yes |
| <a name="input_app_display_name"></a> [app\_display\_name](#input\_app\_display\_name) | (Optional) The display name of the application associated with this service principal. | `string` | `"My_Automation_Account"` | no |
| <a name="input_certificate_validity_period_hours"></a> [certificate\_validity\_period\_hours](#input\_certificate\_validity\_period\_hours) | (Optional) Number of hours the client certificate will be valid for. This is required if use\_certificate = true | `number` | `null` | no |
| <a name="input_client_certificate"></a> [client\_certificate](#input\_client\_certificate) | (Optional) This block is required if use\_certificate = true<br/>common\_name: Distinguished name (e.g myapp.example.com). organization: Distinguished name (i.e YOUR\_ORGANIZATION\_NAME) | <pre>object({<br/>    common_name  = optional(string, null)<br/>    organization = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_create_storage_account"></a> [create\_storage\_account](#input\_create\_storage\_account) | (Optional) Should storage account be created for storing terraform states | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description of the Service Principal being created | `string` | `"Service principal for automation"` | no |
| <a name="input_federation"></a> [federation](#input\_federation) | (Optional) This block is required if use\_oidc = true<br/>This assumes you already have a repository and a project in your organization. | <pre>object({<br/>    azdo_organization_name = optional(string, null)<br/>    azdo_project_name      = optional(string, null)<br/>    azdo_repo_name         = optional(string, null)<br/>    azdo_branch            = optional(string, "*")<br/>  })</pre> | `{}` | no |
| <a name="input_my_publicIP"></a> [my\_publicIP](#input\_my\_publicIP) | (Optional) public/private IP address to allow access to Key Vault and Storage account | `string` | `""` | no |
| <a name="input_spn_client_id_name"></a> [spn\_client\_id\_name](#input\_spn\_client\_id\_name) | (Optional) Name given to the service principal's client ID. Required if use\_secret = true | `string` | `"spn_client_id"` | no |
| <a name="input_spn_password"></a> [spn\_password](#input\_spn\_password) | (Optional) Object references to the Service Principal password | <pre>object({<br/>    display_name = optional(string, null)<br/>    start_date   = optional(any, null)<br/>    end_date     = optional(any, null)<br/>  })</pre> | `{}` | no |
| <a name="input_spn_secret_name"></a> [spn\_secret\_name](#input\_spn\_secret\_name) | (Optional) Name given to the service principal's secret value. Required if use\_secret = true | `string` | `"spn_secret_name"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Optional) Name of the storage account created for the SPN | `string` | `"tfstate"` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | (Optional) Name of the storage container created for the SPN | `string` | `"tfstates-container"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_client_id"></a> [application\_client\_id](#output\_application\_client\_id) | Client ID for the application |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | n/a |
| <a name="output_application_object_id"></a> [application\_object\_id](#output\_application\_object\_id) | Application's object ID |
| <a name="output_end_date"></a> [end\_date](#output\_end\_date) | n/a |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | n/a |
| <a name="output_service_principal_object_id"></a> [service\_principal\_object\_id](#output\_service\_principal\_object\_id) | n/a |
| <a name="output_service_principal_secret_value"></a> [service\_principal\_secret\_value](#output\_service\_principal\_secret\_value) | n/a |
| <a name="output_spn_client_cert"></a> [spn\_client\_cert](#output\_spn\_client\_cert) | client certificate |
| <a name="output_start_date"></a> [start\_date](#output\_start\_date) | n/a |
| <a name="output_tls_self_signed_cert"></a> [tls\_self\_signed\_cert](#output\_tls\_self\_signed\_cert) | n/a |
<!-- END_TF_DOCS -->
