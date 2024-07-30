# Private endpoint example
This module demonstrates the capability to create private endpoints to existing services within the vnet

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
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A mapping of subnet names to their configurations. | <pre>map(object({<br>    prefix = string<br>    delegation = optional(map(object({<br>      service_name    = string<br>      service_actions = list(string)<br>    })), null)<br>    service_endpoints                             = optional(list(string), []),<br>    private_endpoint_network_policies_enabled     = optional(bool, false)<br>    private_link_service_network_policies_enabled = optional(bool, false)<br>    network_security_group_id                     = optional(string, null)<br>    route_table_id                                = optional(string, null)<br>    route_table_alias                             = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_private_dns_zone_suffixes"></a> [private\_dns\_zone\_suffixes](#input\_private\_dns\_zone\_suffixes) | A set of private DNS zones to create | `set(string)` | `[]` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A mapping of private endpoints to create in the virtual network<br>For a list of subresources and DNS zone suffixes see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns | <pre>map(object({<br>    private_dns_zone_suffixes      = list(string)<br>    private_dns_zone_group_name    = string<br>    private_link_subresource_names = list(string)<br>    target_resource_id             = string<br>    subnet_name                    = string<br>  }))</pre> | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | A mapping of route table aliases to route table configuration. | <pre>map(object({<br>    name                          = string<br>    disable_bgp_route_propagation = optional(bool, false)<br>    extra_tags                    = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A mapping of routes to create. | <pre>map(object({<br>    name                   = string<br>    route_table_alias      = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_enable_monitor_private_link_scope"></a> [enable\_monitor\_private\_link\_scope](#input\_enable\_monitor\_private\_link\_scope) | Enable deployment of a private link scope for Azure Monitor<br>This allows workloads on the virtual network to access Azure Monitor services (i.e. log analytics, app insights) privately | `bool` | `false` | no |
| <a name="input_monitor_private_link_scope_subnet_name"></a> [monitor\_private\_link\_scope\_subnet\_name](#input\_monitor\_private\_link\_scope\_subnet\_name) | The name of the subnet to deploy a private endpoint for the monitor private link scope.<br>Required when enable\_monitor\_private\_link\_scope is true. | `string` | `null` | no |
| <a name="input_monitor_private_link_scope_dns_zone_suffixes"></a> [monitor\_private\_link\_scope\_dns\_zone\_suffixes](#input\_monitor\_private\_link\_scope\_dns\_zone\_suffixes) | The DNS zone suffixes for the private link scope | `set(string)` | <pre>[<br>  "privatelink.monitor.azure.com",<br>  "privatelink.oms.opinsights.azure.com",<br>  "privatelink.ods.opinsights.azure.com",<br>  "privatelink.agentsvc.azure-automation.net",<br>  "privatelink.blob.core.windows.net"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "monitor_private_link_scope": {<br>    "max_length": 80,<br>    "name": "ampls"<br>  },<br>  "monitor_private_link_scope_private_endpoint": {<br>    "max_length": 80,<br>    "name": "amplspe"<br>  },<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg"<br>  },<br>  "virtual_network": {<br>    "max_length": 80,<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"sandbox"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"001"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"vnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_transformed_routes"></a> [transformed\_routes](#output\_transformed\_routes) | n/a |
| <a name="output_subnet_route_associations"></a> [subnet\_route\_associations](#output\_subnet\_route\_associations) | n/a |
| <a name="output_private_dns_zones"></a> [private\_dns\_zones](#output\_private\_dns\_zones) | The private dns zones associated with the newly created vNet |
| <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints) | The private endpoints associated with the newly created vNet |
| <a name="output_private_link_scope_id"></a> [private\_link\_scope\_id](#output\_private\_link\_scope\_id) | The id of the newly created private link scope |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
