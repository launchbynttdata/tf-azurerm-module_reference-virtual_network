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

module "resource_names" {
  source  = "d2lqlh14iel5k2.cloudfront.net/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", var.location))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  use_azure_region_abbr   = true
}

module "resource_group" {
  source  = "d2lqlh14iel5k2.cloudfront.net/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-virtual_network.git?ref=fix/route-table-association"
  # source  = "d2lqlh14iel5k2.cloudfront.net/module_primitive/virtual_network/azurerm"
  # version = "~> 3.0"

  resource_group_name  = module.resource_group.name
  vnet_location        = var.location
  vnet_name            = local.virtual_network_name
  address_space        = var.address_space
  bgp_community        = var.bgp_community
  ddos_protection_plan = var.ddos_protection_plan
  dns_servers          = var.dns_servers
  subnets              = local.transformed_subnets
  tags                 = local.tags

  depends_on = [module.resource_group, module.route_tables]
}



module "route_tables" {
  source  = "d2lqlh14iel5k2.cloudfront.net/module_primitive/route_table/azurerm"
  version = "~> 1.0"

  for_each = local.transformed_route_tables

  name                          = each.value.name
  location                      = var.location
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  resource_group_name           = each.value.resource_group_name
  tags                          = merge(local.tags, each.value.extra_tags)

  depends_on = [module.resource_group]
}

module "routes" {
  source  = "d2lqlh14iel5k2.cloudfront.net/module_primitive/route/azurerm"
  version = "~> 1.0"

  routes = local.transformed_routes

  depends_on = [module.resource_group]
}
