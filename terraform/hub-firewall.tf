resource "azurerm_subnet" "vnet-uks-hub-01-snet-azfw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "pip-uks-hub-01" {
  name                = "pip-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  allocation_method   = "Static"
}

resource "azurerm_firewall" "azfw-uks-hub-01" {
  name                = "azfw-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"
}

resource "azurerm_route_table" "compa_default_route" {
  name                = "compa-default-route"
  location            = azurerm_resource_group.rg-uks-compa-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name

  route = [
    {
    name                   = "default"
    address_prefixes       = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}

resource "azurerm_route_table" "compb_default_route" {
  name                = "compb-default-route"
  location            = azurerm_resource_group.rg-uks-compb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compb-net-01.name

  route = [
    {
    name                   = "default"
    address_prefixes       = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}