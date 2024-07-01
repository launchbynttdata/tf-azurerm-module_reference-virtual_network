# // Licensed under the Apache License, Version 2.0 (the "License");
# // you may not use this file except in compliance with the License.
# // You may obtain a copy of the License at
# //
# //     http://www.apache.org/licenses/LICENSE-2.0
# //
# // Unless required by applicable law or agreed to in writing, software
# // distributed under the License is distributed on an "AS IS" BASIS,
# // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# // See the License for the specific language governing permissions and
# // limitations under the License.

//outputs by network module
output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.network.vnet_address_space
}

output "vnet_guid" {
  description = "The GUID of the newly created vNet"
  value       = module.network.vnet_guid
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.network.vnet_id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = module.network.vnet_location
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.network.vnet_name
}

output "subnet_map" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = { for key, value in module.subnets : key => value.subnet }
}

output "subnet_name_id_map" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = { for key, value in module.subnets : key => value.id }
}

output "resource_group_id" {
  description = "resource group id"
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "resource group name"
  value       = module.resource_group.name
}

output "transformed_routes" {
  value = local.transformed_routes
}

output "route_tables_map" {
  value = module.route_tables
}

output "subnet_route_associations" {
  value = module.network.subnet_route_associations
}
