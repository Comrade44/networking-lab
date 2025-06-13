resource "azurerm_resource_group" "rg-uks-hub-01" {
  name     = "rg-uks-hub-01"
  location = "uksouth"
}

resource "azurerm_virtual_network" "vnet-uks-hub-01" {
  name                = "vnet-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-uks-hub-01-snet-01" {
  name                 = "vnet-uks-hub-01-snet-01"
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network_peering" "compb-uks-hub-uks" {
  name                      = "compb-uks-hub-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-compb-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-compb-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-hub-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-uks-compb-uks" {
  name                      = "hub-uks-compb-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-hub-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-compb-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "compa-uks-hub-uks" {
  name                      = "compa-uks-hub-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-compa-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-compa-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-hub-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-uks-compa-uks" {
  name                      = "hub-uks-compa-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-hub-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-compa-01.id
  allow_forwarded_traffic   = true
}
