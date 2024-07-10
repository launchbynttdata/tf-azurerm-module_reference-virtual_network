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

module "storage_resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    storage_account = {
      name       = "sa"
      max_length = 24
    }
  }

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

module "storage_resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = module.storage_resource_names["resource_group"].minimal_random_suffix
  location = var.location
  tags     = var.tags
}

module "storage_account" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/storage_account/azurerm"
  version = "~> 1.0"

  resource_group_name  = module.storage_resource_group.name
  storage_account_name = module.storage_resource_names["storage_account"].minimal_random_suffix_without_any_separators
  location             = var.location

  depends_on = [module.storage_resource_group]
}

module "network" {
  source = "../.."

  location             = var.location
  address_space        = var.address_space
  bgp_community        = var.bgp_community
  ddos_protection_plan = var.ddos_protection_plan
  dns_servers          = var.dns_servers
  subnets              = var.subnets

  routes       = var.routes
  route_tables = var.route_tables

  private_dns_zone_suffixes = var.private_dns_zone_suffixes
  private_endpoints = {
    for key, endpoint in var.private_endpoints : key => key == "storage" ? merge(endpoint, {
      target_resource_id = module.storage_account.id
    }) : endpoint
  }

  resource_names_map      = var.resource_names_map
  environment             = var.environment
  environment_number      = var.environment_number
  resource_number         = var.resource_number
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service

  tags = local.tags
}
