resource "azurerm_resource_group" "uks-hub-vnet-rg" {
  name     = "rg-uks-hub-net-01"
  location = "uksouth"
}

resource "azurerm_virtual_network" "uks-hub-vnet" {
  name                = "vnet-uks-hub-net-01"
  location            = azurerm_resource_group.uks-hub-vnet-rg.location
  resource_group_name = azurerm_resource_group.uks-hub-vnet-rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "uks-hub-snet-01" {
  name                 = "snet-01-uks-hub-net-01"
  virtual_network_name = azurerm_virtual_network.uks-hub-vnet.name
  resource_group_name  = azurerm_resource_group.uks-hub-vnet-rg.name
  address_prefixes     = ["10.0.1.0/24"]
}