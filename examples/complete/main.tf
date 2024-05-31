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

  location             = var.location
  address_space        = var.address_space
  bgp_community        = var.bgp_community
  ddos_protection_plan = var.ddos_protection_plan
  dns_servers          = var.dns_servers
  subnets              = var.subnets

  routes       = var.routes
  route_tables = var.route_tables

  resource_names_map      = var.resource_names_map
  environment             = var.environment
  environment_number      = var.environment_number
  resource_number         = var.resource_number
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service

  tags = var.tags
}
