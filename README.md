# tf-azurerm-module_reference-virtual_network

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module is used to deploy one or more virtual networks and subnets.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_network"></a> [network](#module\_network) | terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm | ~> 3.0 |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | terraform.registry.launch.nttdata.com/module_primitive/virtual_network_subnet/azurerm | ~> 1.0 |
| <a name="module_private_dns_zones"></a> [private\_dns\_zones](#module\_private\_dns\_zones) | terraform.registry.launch.nttdata.com/module_primitive/private_dns_zone/azurerm | ~> 1.0 |
| <a name="module_private_dns_zone_vnet_links"></a> [private\_dns\_zone\_vnet\_links](#module\_private\_dns\_zone\_vnet\_links) | terraform.registry.launch.nttdata.com/module_primitive/private_dns_vnet_link/azurerm | ~> 1.0 |
| <a name="module_private_endpoint_resource_names"></a> [private\_endpoint\_resource\_names](#module\_private\_endpoint\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_private_service_connection_resource_names"></a> [private\_service\_connection\_resource\_names](#module\_private\_service\_connection\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_private_endpoints"></a> [private\_endpoints](#module\_private\_endpoints) | terraform.registry.launch.nttdata.com/module_primitive/private_endpoint/azurerm | ~> 1.0 |
| <a name="module_route_tables"></a> [route\_tables](#module\_route\_tables) | terraform.registry.launch.nttdata.com/module_primitive/route_table/azurerm | ~> 1.0 |
| <a name="module_routes"></a> [routes](#module\_routes) | terraform.registry.launch.nttdata.com/module_primitive/route/azurerm | ~> 1.0 |
| <a name="module_monitor_private_link_scope"></a> [monitor\_private\_link\_scope](#module\_monitor\_private\_link\_scope) | terraform.registry.launch.nttdata.com/module_primitive/azure_monitor_private_link_scope/azurerm | ~> 1.0 |
| <a name="module_monitor_private_link_scope_dns_zone"></a> [monitor\_private\_link\_scope\_dns\_zone](#module\_monitor\_private\_link\_scope\_dns\_zone) | terraform.registry.launch.nttdata.com/module_primitive/private_dns_zone/azurerm | ~> 1.0 |
| <a name="module_monitor_private_link_scope_vnet_link"></a> [monitor\_private\_link\_scope\_vnet\_link](#module\_monitor\_private\_link\_scope\_vnet\_link) | terraform.registry.launch.nttdata.com/module_primitive/private_dns_vnet_link/azurerm | ~> 1.0 |
| <a name="module_monitor_private_link_scope_private_endpoint"></a> [monitor\_private\_link\_scope\_private\_endpoint](#module\_monitor\_private\_link\_scope\_private\_endpoint) | terraform.registry.launch.nttdata.com/module_primitive/private_endpoint/azurerm | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location of the vnet and resource group to create. | `string` | n/a | yes |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `list(string)` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | (Optional) The BGP community attribute in format `<as-number>:<community-value>`. | `string` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | The set of DDoS protection plan configuration | <pre>object({<br>    enable = bool<br>    id     = string<br>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | The DNS servers to be used with vNet. | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A mapping of subnet names to their configurations. | <pre>map(object({<br>    prefix = string<br>    delegation = optional(map(object({<br>      service_name    = string<br>      service_actions = list(string)<br>    })), {})<br>    service_endpoints                             = optional(list(string), []),<br>    private_endpoint_network_policies             = optional(string, null)<br>    private_endpoint_network_policies_enabled     = optional(bool, false)<br>    private_link_service_network_policies_enabled = optional(bool, false)<br>    network_security_group_id                     = optional(string, null)<br>    route_table_id                                = optional(string, null)<br>    route_table_alias                             = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_private_endpoint_resource_names_map"></a> [private\_endpoint\_resource\_names\_map](#input\_private\_endpoint\_resource\_names\_map) | A map of key to resource\_name that will be used to generate private endpoint resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "private_endpoint": {<br>    "max_length": 80,<br>    "name": "pe"<br>  },<br>  "private_service_connection": {<br>    "max_length": 80,<br>    "name": "psc"<br>  }<br>}</pre> | no |
| <a name="input_private_dns_zone_suffixes"></a> [private\_dns\_zone\_suffixes](#input\_private\_dns\_zone\_suffixes) | A set of private DNS zones to create | `set(string)` | `[]` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A mapping of private endpoints to create in the virtual network<br>For a list of subresources and DNS zone suffixes see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns | <pre>map(object({<br>    private_dns_zone_suffixes      = list(string)<br>    private_dns_zone_group_name    = string<br>    private_link_subresource_names = list(string)<br>    target_resource_id             = string<br>    subnet_name                    = string<br>  }))</pre> | `{}` | no |
| <a name="input_enable_monitor_private_link_scope"></a> [enable\_monitor\_private\_link\_scope](#input\_enable\_monitor\_private\_link\_scope) | Enable deployment of a private link scope for Azure Monitor<br>This allows workloads on the virtual network to access Azure Monitor services (i.e. log analytics, app insights) privately | `bool` | `false` | no |
| <a name="input_monitor_private_link_scope_subnet_name"></a> [monitor\_private\_link\_scope\_subnet\_name](#input\_monitor\_private\_link\_scope\_subnet\_name) | The name of the subnet to deploy a private endpoint for the monitor private link scope.<br>Required when enable\_monitor\_private\_link\_scope is true. | `string` | `null` | no |
| <a name="input_monitor_private_link_scope_dns_zone_suffixes"></a> [monitor\_private\_link\_scope\_dns\_zone\_suffixes](#input\_monitor\_private\_link\_scope\_dns\_zone\_suffixes) | The DNS zone suffixes for the private link scope | `set(string)` | <pre>[<br>  "privatelink.monitor.azure.com",<br>  "privatelink.oms.opinsights.azure.com",<br>  "privatelink.ods.opinsights.azure.com",<br>  "privatelink.agentsvc.azure-automation.net",<br>  "privatelink.blob.core.windows.net"<br>]</pre> | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | A mapping of route table aliases to route table configuration. | <pre>map(object({<br>    name                          = string<br>    disable_bgp_route_propagation = optional(bool, false)<br>    extra_tags                    = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A mapping of routes to create. | <pre>map(object({<br>    name                   = string<br>    route_table_alias      = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources that are created by this module. | `map(string)` | `{}` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "monitor_private_link_scope": {<br>    "max_length": 80,<br>    "name": "ampls"<br>  },<br>  "monitor_private_link_scope_private_endpoint": {<br>    "max_length": 80,<br>    "name": "amplspe"<br>  },<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg"<br>  },<br>  "virtual_network": {<br>    "max_length": 80,<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | n/a | yes |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | n/a | yes |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet |
| <a name="output_vnet_guid"></a> [vnet\_guid](#output\_vnet\_guid) | The GUID of the newly created vNet |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the newly created vNet |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location) | The location of the newly created vNet |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The Name of the newly created vNet |
| <a name="output_subnet_map"></a> [subnet\_map](#output\_subnet\_map) | The ids of subnets created inside the newly created vNet |
| <a name="output_private_dns_zones"></a> [private\_dns\_zones](#output\_private\_dns\_zones) | The private dns zones associated with the newly created vNet |
| <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints) | The private endpoints associated with the newly created vNet |
| <a name="output_monitor_private_link_scope_id"></a> [monitor\_private\_link\_scope\_id](#output\_monitor\_private\_link\_scope\_id) | The id of the monitor private link scope |
| <a name="output_subnet_name_id_map"></a> [subnet\_name\_id\_map](#output\_subnet\_name\_id\_map) | Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet\_subnets\_name\_id, subnet1) |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | resource group id |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | resource group name |
| <a name="output_transformed_routes"></a> [transformed\_routes](#output\_transformed\_routes) | n/a |
| <a name="output_route_tables_map"></a> [route\_tables\_map](#output\_route\_tables\_map) | n/a |
| <a name="output_subnet_route_associations"></a> [subnet\_route\_associations](#output\_subnet\_route\_associations) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
