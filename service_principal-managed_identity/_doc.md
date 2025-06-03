# Terraform Azure Service Principal and Managed Identity Module
This module creates Service Principal (with client secrets, OIDC, or client certificate).\
This module also creates Azure Key Vault to store Service Principal secret value and its related attributes,\
 as well as storage account for terraform states used by the Service Principal.

Set one or more of the service principal/managed identity input variable to "true" to use for authentication.\
```hcl
use_secret      = false
use_oidc        = true # if "true", its associated attributes MUST BE PROVIDED!
use_certificate = false
```
## Note 
The user principal assigning the API permissions to the newly created Service Principal must have a `Global Administrator` role\
or `Application.ReadWrite.All` and `Directory.ReadWrite.All` API permission assigned to a Service Principal to successfully assign those permissions for newly created Service Principals.\
Then, go to the portal to explicitly grant `admin consent` to the Service Principal.

### Example - Service Principal with client secret
This example shows how to use the module to create spn with client secret. Other authentication methods can be used as well by setting the respective variable to `true`
