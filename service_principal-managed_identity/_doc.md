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
## Note 
The user principal assigning the API permissions to the newly created Service Principal must have a `Global Administrator` role\
or `Application.ReadWrite.All` and `Directory.ReadWrite.All` API permission assigned to a Service Principal to successfully assign those permissions.\
for newly created Service Principals.\
Then the "admin consent" must be explicitly granted to the Service Principal after deployment.

### Example - Service Principal with client secret
This example shows how to use the module to create spn with client secret. Other authentication methods can be used as well by setting the respective variable to `true`
