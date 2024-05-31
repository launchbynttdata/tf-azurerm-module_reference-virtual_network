locals {
  default_tags = {
    "provisioner" = "terraform"
  }
  vnet_tags           = merge(var.vnet_tags, local.default_tags)
  resource_group_tags = merge(var.resource_group_tags, local.default_tags)

  resource_group_name  = module.resource_names["resource_group"].standard
  virtual_network_name = module.resource_names["virtual_network"].standard

  transformed_route_tables = {
    for route_table_alias, route_table_definition in var.var.route_tables :
    route_table_alias => merge(route_table_definition, {
      resource_group_name = local.resource_group_name
      tags                = merge(local.default_tags, route_table_definition.extra_tags)
    })
  }
}
