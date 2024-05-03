locals {
  default_tags = {
    "provisioner" = "terraform"
  }
  vnet_tags           = merge(var.vnet_tags, local.default_tags)
  resource_group_tags = merge(var.resource_group_tags, local.default_tags)

  resource_group_name  = module.resource_names["resource_group"].standard
  virtual_network_name = module.resource_names["virtual_network"].standard
}
