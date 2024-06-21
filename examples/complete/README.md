# Complete example
 This module emulates a Hub and Spoke architecture model by creating multiple Vnets and subnets using same terraform module. Each Vnet is created in its own Resource Group. The Vnet attributes are configurable through the input parameters

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
| <a name="module_network"></a> [network](#module\_network) | ../.. | n/a |

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
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A mapping of subnet names to their configurations. | <pre>map(object({<br>    prefix = string<br>    delegation = optional(object({<br>      name    = string<br>      actions = list(string)<br>    }), null)<br>    service_endpoints                             = optional(list(string), []),<br>    private_endpoint_network_policies_enabled     = optional(bool, false)<br>    private_link_service_network_policies_enabled = optional(bool, false)<br>    network_security_group_id                     = optional(string, null)<br>    route_table_id                                = optional(string, null)<br>    route_table_alias                             = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | A mapping of route table aliases to route table configuration. | <pre>map(object({<br>    name                          = string<br>    disable_bgp_route_propagation = optional(bool, false)<br>    extra_tags                    = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A mapping of routes to create. | <pre>map(object({<br>    name                   = string<br>    route_table_alias      = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "name": "rg"<br>  },<br>  "virtual_network": {<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"sandbox"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"vnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_transformed_routes"></a> [transformed\_routes](#output\_transformed\_routes) | n/a |
| <a name="output_subnet_route_associations"></a> [subnet\_route\_associations](#output\_subnet\_route\_associations) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
