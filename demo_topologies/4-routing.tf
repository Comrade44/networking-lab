resource "azurerm_route_table" "spokea_default_route" {
  name                = "spokea-default-route"
  location            = azurerm_resource_group.rg-uks-spokea-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokea-net-01.name

  route = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}

resource "azurerm_subnet_route_table_association" "spokea_routes" {
  route_table_id = azurerm_route_table.spokea_default_route.id
  subnet_id      = azurerm_subnet.vnet-uks-spokea-01-snet-01.id
}

resource "azurerm_route_table" "spokeb_default_route" {
  name                = "spokeb-default-route"
  location            = azurerm_resource_group.rg-uks-spokeb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokeb-net-01.name

  route = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}

resource "azurerm_subnet_route_table_association" "spokeb_routes" {
  route_table_id = azurerm_route_table.spokeb_default_route.id
  subnet_id      = azurerm_subnet.vnet-uks-spokeb-01-snet-01.id
}