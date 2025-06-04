[![Build Status](https://dev.azure.com/MosesOwaseye/Service%20Principal/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Service%20Principal/_build/latest?definitionId=37&branchName=main)

# Terraform Azure Service Principal Module
This module creates Service Principal (with client secrets, OIDC, or client certificate).\
This module also creates Azure Key Vault to store Service Principal secret value and its related attributes,\
 as well as storage account for terraform states used by the Service Principal.

Set one or more of the service principal input variable to "true" to use for authentication.\
```hcl
use_secret      = false
use_oidc        = true 
use_certificate = false
```
## Note 
The user principal assigning the API permissions to the newly created Service Principal must have a `Global Administrator` role\
or `Application.ReadWrite.All` and `Directory.ReadWrite.All` API permission assigned to a Service Principal to successfully assign those permissions for newly created Service Principals.\
Then, go to the portal to explicitly grant `admin consent` to the Service Principal.

### Complete Example - Service Principal with all methods
This example shows how to use the module to create spn with client secret, client certificate, and OIDC by setting their variables to `true`
