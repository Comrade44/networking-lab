resource "azurerm_resource_group" "uks-spoke1-vnet-rg" {
  name     = "rg-uks-spoke1-net-01"
  location = "uksouth"
}

resource "azurerm_virtual_network" "uks-spoke1-vnet" {
  name                = "vnet-uks-spoke1-net-01"
  location            = azurerm_resource_group.uks-spoke1-vnet-rg.location
  resource_group_name = azurerm_resource_group.uks-spoke1-vnet-rg.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "uks-spoke1-snet-01" {
  name                 = "snet-01-uks-spoke1-net-01"
  virtual_network_name = azurerm_virtual_network.uks-spoke1-vnet.name
  resource_group_name  = azurerm_resource_group.uks-spoke1-vnet-rg.name
  address_prefixes     = ["10.10.1.0/24"]
}