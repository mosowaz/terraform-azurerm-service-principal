[![Build Status](https://dev.azure.com/MosesOwaseye/Service%20Principal/_apis/build/status%2FDeploy%20Resources?branchName=dev)](https://dev.azure.com/MosesOwaseye/Service%20Principal/_build/latest?definitionId=39&branchName=dev)

# Terraform Azure Service Principal Module
This module creates Service Principal (with client secrets, OIDC, or client certificate).\

Set one or more of the service principal input variable to "true" to use for authentication.

```hcl
use_secret      = false
use_oidc        = true 
use_certificate = false
```

### Complete Example - Service Principal with all methods
This example shows how to use the module to create spn with client secret, client certificate, and OIDC by setting their variables to `true`
