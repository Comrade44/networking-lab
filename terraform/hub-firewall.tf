resource "azurerm_subnet" "vnet-uks-hub-01-snet-azfw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "vnet-uks-hub-01-snet-azfwmgmt" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip-uks-hub-01" {
  name                = "pip-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  allocation_method   = "Static"
}


resource "azurerm_public_ip" "pip-uks-hub-02" {
  name                = "pip-uks-hub-02"
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
  ip_configuration {
    name                 = "hub"
    subnet_id            = azurerm_subnet.vnet-uks-hub-01-snet-azfw.id
    public_ip_address_id = azurerm_public_ip.pip-uks-hub-01.id
  }
  management_ip_configuration {
    name                 = "management"
    subnet_id            = azurerm_subnet.vnet-uks-hub-01-snet-azfwmgmt.id
    public_ip_address_id = azurerm_public_ip.pip-uks-hub-02.id
  }
}

resource "azurerm_route_table" "compa_default_route" {
  name                = "compa-default-route"
  location            = azurerm_resource_group.rg-uks-compa-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name

  route = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}

resource "azurerm_subnet_route_table_association" "compa_routes" {
  route_table_id = azurerm_route_table.compa_default_route.id
  subnet_id      = azurerm_subnet.vnet-uks-compa-01-snet-01.id
}

resource "azurerm_route_table" "compb_default_route" {
  name                = "compb-default-route"
  location            = azurerm_resource_group.rg-uks-compb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compb-net-01.name

  route = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = azurerm_firewall.azfw-uks-hub-01.ip_configuration[0].private_ip_address
    }
  ]
}

resource "azurerm_subnet_route_table_association" "compb_routes" {
  route_table_id = azurerm_route_table.compb_default_route.id
  subnet_id      = azurerm_subnet.vnet-uks-compb-01-snet-01.id
}