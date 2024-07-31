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


variable "location" {
  type        = string
  description = "The location of the vnet and resource group to create."
  nullable    = false
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}

variable "bgp_community" {
  type        = string
  default     = null
  description = "(Optional) The BGP community attribute in format `<as-number>:<community-value>`."
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  default     = null
  description = "The set of DDoS protection plan configuration"
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "subnets" {
  description = "A mapping of subnet names to their configurations."
  type = map(object({
    prefix = string
    delegation = optional(map(object({
      service_name    = string
      service_actions = list(string)
    })), {})
    service_endpoints                             = optional(list(string), []),
    private_endpoint_network_policies             = optional(string, null)
    private_endpoint_network_policies_enabled     = optional(bool, false)
    private_link_service_network_policies_enabled = optional(bool, false)
    network_security_group_id                     = optional(string, null)
    route_table_id                                = optional(string, null)
    route_table_alias                             = optional(string, null)
  }))
  default = {}

  validation {
    condition     = alltrue([for subnet_name, subnet in var.subnets : !(subnet.route_table_id != null && subnet.route_table_alias != null)])
    error_message = "Subnets may define either a route_table_id or a route_table_alias, but not both."
  }
}

variable "private_endpoint_resource_names_map" {
  description = "A map of key to resource_name that will be used to generate private endpoint resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    private_endpoint = {
      name       = "pe"
      max_length = 80
    }
    private_service_connection = {
      name       = "psc"
      max_length = 80
    }
  }
}

variable "private_dns_zone_suffixes" {
  description = "A set of private DNS zones to create"
  type        = set(string)
  default     = []
}

variable "private_endpoints" {
  description = <<-EOF
    A mapping of private endpoints to create in the virtual network
    For a list of subresources and DNS zone suffixes see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
  EOF
  type = map(object({
    private_dns_zone_suffixes      = list(string)
    private_dns_zone_group_name    = string
    private_link_subresource_names = list(string)
    target_resource_id             = string
    subnet_name                    = string
  }))
  default = {}

  validation {
    condition     = alltrue([for key, value in var.private_endpoints : key != "ampls"])
    error_message = "The key 'ampls' is reserved for the monitor private link scope private endpoint"
  }
}

variable "enable_monitor_private_link_scope" {
  description = <<-EOF
    Enable deployment of a private link scope for Azure Monitor
    This allows workloads on the virtual network to access Azure Monitor services (i.e. log analytics, app insights) privately
  EOF
  type        = bool
  default     = false
}

variable "monitor_private_link_scope_subnet_name" {
  description = <<-EOF
    The name of the subnet to deploy a private endpoint for the monitor private link scope.
    Required when enable_monitor_private_link_scope is true.
  EOF
  type        = string
  default     = null
}

variable "monitor_private_link_scope_dns_zone_suffixes" {
  description = "The DNS zone suffixes for the private link scope"
  type        = set(string)
  default = [
    "privatelink.monitor.azure.com",
    "privatelink.oms.opinsights.azure.com",
    "privatelink.ods.opinsights.azure.com",
    "privatelink.agentsvc.azure-automation.net",
    "privatelink.blob.core.windows.net"
  ]
}

variable "route_tables" {
  description = "A mapping of route table aliases to route table configuration."
  type = map(object({
    name                          = string
    disable_bgp_route_propagation = optional(bool, false)
    extra_tags                    = optional(map(string), {})
  }))
  default = {}
}

variable "routes" {
  description = "A mapping of routes to create."
  type = map(object({
    name                   = string
    route_table_alias      = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string, null)
  }))
  default = {}

  validation {
    condition     = alltrue([for route_name, route_definition in var.routes : contains(["VirtualNetworkGateway", "VnetLocal", "Internet", "VirtualAppliance", "None"], route_definition.next_hop_type)])
    error_message = "next_hop_type must contain 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'VirtualAppliance', or 'None'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources that are created by this module."
  default     = {}
}

//variables required by resource names module
variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    virtual_network = {
      name       = "vnet"
      max_length = 80
    }
    monitor_private_link_scope = {
      name       = "ampls"
      max_length = 80
    }
    monitor_private_link_scope_private_endpoint = {
      name       = "amplspe"
      max_length = 80
    }
  }
}

// TODO: remove this in favor of `class_env` next major release
variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "sandbox"
}

// TODO: give this a default value and make non-nullable in the next major release
variable "class_env" {
  type        = string
  description = "Environment where resource is going to be deployed. For example. dev, qa, uat"
  default     = null

  validation {
    condition     = length(regexall("\\b \\b", coalesce(var.class_env, "dev"))) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

// TODO: remove this in favor of `instance_env` next major release
variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

// TODO: give this a default value and make non-nullable in the next major release
variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = null

  validation {
    condition     = coalesce(var.instance_env, 0) >= 0 && coalesce(var.instance_env, 0) <= 100
    error_message = "Instance number should be between 0 to 999."
  }
}

// TODO: remove this in favore of `instance_resource` next major release
variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

// TODO: give this a default value and make non-nullable in the next major release
variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = null

  validation {
    condition     = coalesce(var.instance_resource, 0) >= 0 && coalesce(var.instance_resource, 0) <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}
