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

output "private_dns_zones" {
  description = "The private dns zones associated with the newly created vNet"
  value = merge(
    module.private_dns_zones,
    { for key, value in module.monitor_private_link_scope_dns_zone : key => value }
  )
}

output "private_endpoints" {
  description = "The private endpoints associated with the newly created vNet"
  value = merge(
    module.private_endpoints,
    { for key, value in module.monitor_private_link_scope_private_endpoint : key => value }
  )
}

output "monitor_private_link_scope_id" {
  description = "The id of the monitor private link scope"
  value       = length(module.monitor_private_link_scope) > 0 ? module.monitor_private_link_scope[0].private_link_scope_id : null
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

# --- Private DNS Zone outputs (IDs only) -------------------------------------

# Map: zone_name => zone_id (merged from both DNS zone sources)
output "private_dns_zone_ids_by_name" {
  description = "Private DNS Zone IDs keyed by zone name (merged from private_dns_zones and monitor_private_link_scope_dns_zone)."
  value = merge(
    { for name, m in module.private_dns_zones :
        name => try(m.id, m.zone_id, null)
      if try(m.id, m.zone_id, null) != null
    },
    { for name, m in module.monitor_private_link_scope_dns_zone :
        name => try(m.id, m.zone_id, null)
      if try(m.id, m.zone_id, null) != null
    }
  )
}

# Set of all zone IDs (unordered), useful for passing to other modules
output "private_dns_zone_ids" {
  description = "All Private DNS Zone IDs as a set (merged)."
  value = toset(compact(concat(
    [for _, m in module.private_dns_zones : try(m.id, m.zone_id, null)],
    [for _, m in module.monitor_private_link_scope_dns_zone : try(m.id, m.zone_id, null)]
  )))
}

# Convenience: when there is exactly one zone in module.private_dns_zones,
# this returns that single ID. (Errors if not exactly one.)
output "single_private_dns_zone_id" {
  description = "ID when exactly one zone is created via module.private_dns_zones."
  value       = one([for _, m in module.private_dns_zones : try(m.id, m.zone_id)])
}

# Optional: if you have a single-instance module "private_dns_zone" anywhere,
# this safely exposes its ID without breaking when it's not present.
# (If you don't have such a module, you can delete this block.)
output "private_dns_zone_id" {
  description = "ID of a single private DNS zone module instance (if you use one)."
  value       = try(module.private_dns_zone.id, module.private_dns_zone.zone_id, null)
}

output "postgres_private_dns_zone_id" {
  description = "The ID of the Postgres private DNS zone."
  value       = var.private_dns_zone_enabled ? azurerm_private_dns_zone.postgres[0].id : null
}

