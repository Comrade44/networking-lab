resource "azurerm_resource_group" "rg-uks-net-01" {
  name     = "rg-uks-net-01"
  location = "uksouth"
}

resource "azurerm_virtual_wan" "vwan-uks-net-01" {
  name                = "vwan-uks-net-01"
  location            = azurerm_resource_group.rg-uks-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-net-01.name
}

resource "azurerm_virtual_hub" "vhub-uks-01" {
  name                = "vhub-uks-01"
  location            = azurerm_resource_group.rg-uks-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-net-01.name
  sku                 = "Standard"
  virtual_wan_id      = azurerm_virtual_wan.vwan-uks-net-01.id
  address_prefix      = "10.0.0.0/16"
}

resource "azurerm_virtual_hub_connection" "spokea-vhub-uks" {
  name                      = "spokea-vhub-uks"
  virtual_hub_id            = azurerm_virtual_hub.vhub-uks-01.id
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-spokea-01.id
}

resource "azurerm_virtual_hub_connection" "spokeb-vhub-uks" {
  name                      = "spokeb-vhub-uks"
  virtual_hub_id            = azurerm_virtual_hub.vhub-uks-01.id
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-spokeb-01.id
}
