// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "network" {
  source = "../.."

  use_for_each                                     = var.use_for_each
  location                                         = var.location
  address_space                                    = var.address_space
  bgp_community                                    = var.bgp_community
  ddos_protection_plan                             = var.ddos_protection_plan
  dns_servers                                      = var.dns_servers
  nsg_ids                                          = var.nsg_ids
  route_tables_ids                                 = var.route_tables_ids
  subnet_delegation                                = var.subnet_delegation
  subnet_private_endpoint_network_policies_enabled = var.subnet_private_endpoint_network_policies_enabled
  subnet_names                                     = var.subnet_names
  subnet_prefixes                                  = var.subnet_prefixes
  subnet_service_endpoints                         = var.subnet_service_endpoints
  vnet_tags                                        = var.vnet_tags

  resource_names_map      = var.resource_names_map
  environment             = var.environment
  environment_number      = var.environment_number
  resource_number         = var.resource_number
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service

  resource_group_tags = var.resource_group_tags
}
