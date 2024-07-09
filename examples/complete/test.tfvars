location = "eastus"

address_space = ["172.16.0.0/16"]

subnets = {
  ExampleSubnet = {
    prefix = "172.16.0.0/24"
  }
  ExampleSubnetWithRoutingTable = {
    prefix            = "172.16.1.0/24"
    route_table_alias = "ExampleRouteTable"
  }
  ExampleSubnetWithSameRoutingTable = {
    prefix            = "172.16.2.0/24"
    route_table_alias = "ExampleRouteTable"
  }
  ExampleSubnetWithDelegation = {
    prefix = "172.16.3.0/24"
    delegation = {
      dns-resolver = {
        service_name    = "Microsoft.Network/dnsResolvers"
        service_actions = ["Microsoft.Network/virtualNetworks/read"]
      }
    }
  }
}

route_tables = {
  ExampleRouteTable = {
    name = "launch-vnet-example-route-table"
  }
}

routes = {
  ExampleApplianceRoute = {
    name                   = "launch-vnet-example-appliance-route"
    route_table_alias      = "ExampleRouteTable"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.1"
  }
  ExampleMoreSpecificRoute = {
    name                   = "launch-vnet-more-specific-appliance-route"
    route_table_alias      = "ExampleRouteTable"
    address_prefix         = "10.0.0.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.1"
  }
}
