<!-- BEGIN_TF_DOCS -->
## Bitbucket Repository Management with Terraform
This Terraform configuration allows you to manage multiple Bitbucket repositories, including their variables and deployments, within a single Bitbucket project.<br>

## Structure
### The configuration is split into several files:

`main.tf`: Contains the main Terraform configuration for creating Bitbucket resources.<br>
`variables.tf`: Defines input variables used in the configuration.<br>
`terraform.tfvars_sample`: Sets values for the defined variables.<br>
`outputs.tf`: Defines outputs that provide useful information after applying the configuration.<br>
`providers.tf`: Configures the Bitbucket provider.<br>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_bitbucket"></a> [bitbucket](#requirement\_bitbucket) | 2.32.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_bitbucket"></a> [bitbucket](#provider\_bitbucket) | 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [bitbucket_commit_file.readme_files](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/commit_file) | resource |
| [bitbucket_deployment.deployments](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/deployment) | resource |
| [bitbucket_deployment_variable.deployment_variables](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/deployment_variable) | resource |
| [bitbucket_project.project](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/project) | resource |
| [bitbucket_repository.repositories](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/repository) | resource |
| [bitbucket_repository_variable.repo_variables](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/resources/repository_variable) | resource |
| [bitbucket_workspace.workspace](https://registry.terraform.io/providers/DrFaust92/bitbucket/2.32.0/docs/data-sources/workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_key"></a> [project\_key](#input\_project\_key) | Key of the project | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_provider_app_key"></a> [provider\_app\_key](#input\_provider\_app\_key) | Bitbucket App Key | `string` | n/a | yes |
| <a name="input_provider_username"></a> [provider\_username](#input\_provider\_username) | Bitbucket Username | `string` | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | Map of repositories to create | <pre>map(object({<br>    name        = string<br>    slug        = string<br>    language    = string<br>    description = string<br>    variables   = map(object({<br>      key     = string<br>      value   = string<br>      secured = bool<br>    }))<br>    deployments = map(object({<br>      name   = string<br>      stage  = string<br>      variables = map(object({<br>        key     = string<br>        value   = string<br>        secured = bool<br>      }))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of workspace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_key"></a> [project\_key](#output\_project\_key) | The key of the created Bitbucket project |
| <a name="output_repository_details"></a> [repository\_details](#output\_repository\_details) | Detailed information about the created Bitbucket repositories |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | URLs of the created Bitbucket repositories |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of the Bitbucket workspace |
<!-- END_TF_DOCS -->