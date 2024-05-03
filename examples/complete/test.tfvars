//Variable for resource names module
environment             = "sandbox"
environment_number      = "000"
resource_number         = "000"
logical_product_family  = "launch"
logical_product_service = "network"
location                = "eastus"
resource_names_map = {

  resource_group = {
    name       = "rg"
    max_length = 80
  }
  virtual_network = {
    name       = "vnet"
    max_length = 80
  }
}
//Variables for networking module
address_space            = ["172.16.0.0/16"]
subnet_names             = ["AppGwSbnt"]
subnet_prefixes          = ["172.16.0.0/24"]
bgp_community            = null
ddos_protection_plan     = null
dns_servers              = []
nsg_ids                  = {}
route_tables_ids         = {}
subnet_delegation        = {}
subnet_service_endpoints = {}
vnet_tags                = {}
use_for_each             = true
subnet_private_endpoint_network_policies_enabled = {
  AppGwSbnt = false
}
