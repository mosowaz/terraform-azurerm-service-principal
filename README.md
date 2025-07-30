<<<<<<< HEAD
<!-- BEGIN_TF_DOCS -->


```hcl

``` 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.28.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rg"></a> [rg](#input\_rg) | n/a | <pre>object({<br/>    name     = string<br/>    location = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
=======
# terraform-azuredevops-module
A collection of terraform modules for creating azuredevops project with option of using github repo and azuredevops repo

## Modules
- [Service Principal](service_principal/)  [![Build Status](https://dev.azure.com/MosesOwaseye/Service%20Principal/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Service%20Principal/_build/latest?definitionId=37&branchName=main)

- [Azure DevOps Project](azuredevops_project/)

- [Service Connection to Github](service_connection_github/)

- [Service Connection to Azure Portal](service_connection_azurerm/)
<<<<<<< HEAD
>>>>>>> 8632c12 (fix: modify variable names, and update example.tf)
=======
>>>>>>> ca9b2ccee3a82c3a350da8cf43ffc2ba10a60cdb
