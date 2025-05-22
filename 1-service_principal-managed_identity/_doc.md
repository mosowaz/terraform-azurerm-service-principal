# Service Principal and Managed Identity
This module creates Service Principal (with either client secrets, OIDC, or client certificate) and Managed Identity.\
This module also create Azure Key Vault to store Service Principal secret value and other attributes,\
 as well as storage account for terraform states used by the Service Principal.
 
Set either of the service principal input variable to "true" to activate the deployment.\
As shown below, "use_spn_with_secret" is used for example.
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