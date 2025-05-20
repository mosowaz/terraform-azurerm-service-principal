# Service Principal and Managed Identity
This module creates Service Principal (with either client secrets, OIDC, or client certificate) and Managed Identity.\
Set either of the service principal input variable to "true" to activate the deployment.\
As shown below, "use_spn_with_secret" is used for example.
```hcl
use_spn_with_secret      = true
use_spn_with_oidc        = false
use_spn_with_certificate = false
use_msi                  = false
```
## Note: 
The user principal assigning the API permissions to the newly created service principal must have a "Global Administrator" role to successfully assign those permissions.