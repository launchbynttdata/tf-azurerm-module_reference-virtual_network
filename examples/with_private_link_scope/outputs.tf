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

output "transformed_routes" {
  value = module.network.transformed_routes
}
output "subnet_route_associations" {
  value = module.network.subnet_route_associations
}

output "private_dns_zones" {
  description = "The private dns zones associated with the newly created vNet"
  value       = module.network.private_dns_zones
}

output "private_endpoints" {
  description = "The private endpoints associated with the newly created vNet"
  value       = module.network.private_endpoints
}

output "private_link_scope_id" {
  description = "The id of the newly created private link scope"
  value       = module.network.monitor_private_link_scope_id
}
