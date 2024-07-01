locals {
  default_tags = {
    "provisioner" = "terraform"
  }
  tags = merge(local.default_tags, var.tags)

  resource_group_name  = module.resource_names["resource_group"].standard
  virtual_network_name = module.resource_names["virtual_network"].standard

  transformed_subnets = {
    for subnet_alias, subnet_definition in var.subnets :
    subnet_alias => merge(subnet_definition, {
      route_table_name                  = subnet_definition.route_table_alias != null ? module.route_tables[subnet_definition.route_table_alias].name : null
      private_endpoint_network_policies = subnet_definition.private_endpoint_network_policies != null ? subnet_definition.private_endpoint_network_policies : subnet_definition.private_endpoint_network_policies_enabled ? "Enabled" : "Disabled"
    })
  }

  transformed_route_tables = {
    for route_table_alias, route_table_definition in var.route_tables :
    route_table_alias => merge(route_table_definition, {
      resource_group_name = local.resource_group_name
      tags                = merge(local.default_tags, route_table_definition.extra_tags)
    })
  }

  transformed_routes = {
    for route_alias, route_definition in var.routes :
    route_alias => merge(route_definition, {
      resource_group_name = local.resource_group_name
      route_table_name    = module.route_tables[route_definition.route_table_alias].name
    })
  }
}
