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

resource "azurerm_virtual_network_peering" "spokeb-uks-hub-uks" {
  name                      = "spokeb-uks-hub-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-spokeb-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-spokeb-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-hub-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-uks-spokeb-uks" {
  name                      = "hub-uks-spokeb-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-hub-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-spokeb-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spokea-uks-hub-uks" {
  name                      = "spokea-uks-hub-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-spokea-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-spokea-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-hub-01.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-uks-spokea-uks" {
  name                      = "hub-uks-spokea-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-hub-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-spokea-01.id
  allow_forwarded_traffic   = true
}
