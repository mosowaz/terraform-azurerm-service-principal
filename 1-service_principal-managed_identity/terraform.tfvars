resource_group = {
  name     = "service_principal_and_identity"
  location = "canadacentral"
}

use_spn_with_secret = true
use_spn_with_oidc   = false
use_msi             = false

app_role_ids = [ "1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9", 
                  "19dbc75e-c2e2-444c-a770-ec69d8559fc7" ]