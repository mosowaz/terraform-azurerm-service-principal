<!-- BEGIN_TF_DOCS -->
# Terraform Azure Service Principal and Managed Identity Module
This module creates Service Principal (with client secrets, OIDC, or client certificate) and Managed Identity.\
This module also creates Azure Key Vault to store Service Principal secret value and its related attributes,\
 as well as storage account for terraform states used by the Service Principal.

Set one of the service principal/managed identity input variable to "true" to activate the deployment.\
Here, `use_spn_with_secret` is used as an example.
```hcl
use_spn_with_secret      = true
use_spn_with_oidc        = false
use_spn_with_certificate = false
use_msi                  = false
```
## Note:
The user principal assigning the API permissions to the newly created Service Principal must have a "Global Administrator" role\
or "Application.ReadWrite.All" and "Directory.ReadWrite.All" API permission assigned to a Service Principal to successfully assign those permissions.\
for newly created Service Principals.\
Then the "admin consent" must be explicitly granted to the Service Principal after deployment.

```hcl

``` 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.28.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

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
| [azuread_service_principal.service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.spn_secret](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.iam_roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_service_principal.msgraph_api](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.spn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.primary_owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_role_definition.owner_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_role_ids"></a> [app\_role\_ids](#input\_app\_role\_ids) | API permissions required by the service principal running terraform apply | `list(string)` | n/a | yes |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | IAM roles required for the Service Principal to perform operations | `list(string)` | n/a | yes |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | Name of the Key Vault | `string` | n/a | yes |
| <a name="input_my_publicIP"></a> [my\_publicIP](#input\_my\_publicIP) | Your public IP address to allow access Key Vault and Storage account | `any` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Name and location of resource group | <pre>object({<br/>    name     = string<br/>    location = string<br/>  })</pre> | n/a | yes |
| <a name="input_spn_client_id_name"></a> [spn\_client\_id\_name](#input\_spn\_client\_id\_name) | Name given to the service principal's client ID | `string` | n/a | yes |
| <a name="input_spn_password"></a> [spn\_password](#input\_spn\_password) | List of object references to the Service Principal password | <pre>object({<br/>    display_name = string<br/>    start_date   = optional(any, null)<br/>    end_date     = optional(any, null)<br/>  })</pre> | n/a | yes |
| <a name="input_spn_secret_name"></a> [spn\_secret\_name](#input\_spn\_secret\_name) | Name given to the service principal's secret value | `string` | n/a | yes |
| <a name="input_spn_subscription_id_name"></a> [spn\_subscription\_id\_name](#input\_spn\_subscription\_id\_name) | Name given to the service principal's subscription ID | `string` | n/a | yes |
| <a name="input_spn_tenant_id_name"></a> [spn\_tenant\_id\_name](#input\_spn\_tenant\_id\_name) | Name given to the service principal's tenant ID | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account created for the SPN | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Name of the storage container created for the SPN | `string` | n/a | yes |
| <a name="input_use_existing"></a> [use\_existing](#input\_use\_existing) | When true, any existing service principal linked to the same application will be automatically imported. <br/>When false, an import error will be raised for any pre-existing service principal. | `bool` | n/a | yes |
| <a name="input_use_msi"></a> [use\_msi](#input\_use\_msi) | Should Managed Identity be used for authentication? | `bool` | n/a | yes |
| <a name="input_use_spn_with_certificate"></a> [use\_spn\_with\_certificate](#input\_use\_spn\_with\_certificate) | Should the Service Principal be used to authenticate with Client Certificate? | `bool` | n/a | yes |
| <a name="input_use_spn_with_oidc"></a> [use\_spn\_with\_oidc](#input\_use\_spn\_with\_oidc) | Should the Service Principal be used to authenticate with OpenID Connect? | `bool` | n/a | yes |
| <a name="input_use_spn_with_secret"></a> [use\_spn\_with\_secret](#input\_use\_spn\_with\_secret) | Should the Service Principal be used to authenticate with Client Secret? | `bool` | n/a | yes |
| <a name="input_app_display_name"></a> [app\_display\_name](#input\_app\_display\_name) | The display name of the application associated with this service principal. | `string` | `"My_Automation_Account"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the SPN being created | `string` | `"Service principal for automation"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_client_id"></a> [application\_client\_id](#output\_application\_client\_id) | Client ID for the application |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | n/a |
| <a name="output_application_object_id"></a> [application\_object\_id](#output\_application\_object\_id) | Application's object ID |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | n/a |
| <a name="output_service_principal_object_id"></a> [service\_principal\_object\_id](#output\_service\_principal\_object\_id) | n/a |
| <a name="output_service_principal_secret_value"></a> [service\_principal\_secret\_value](#output\_service\_principal\_secret\_value) | n/a |
<!-- END_TF_DOCS -->