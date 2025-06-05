resource "azurerm_resource_group" "rg-uks-compa-net-01" {
  name     = "rg-uks-compa-net-01"
  location = "uksouth"
}

resource "azurerm_virtual_network" "vnet-uks-compa-01" {
  name                = "vnet-uks-compa-01"
  location            = azurerm_resource_group.rg-uks-compa-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "vnet-uks-compa-01-snet-01" {
  name                 = "vnet-uks-compa-01-snet-01"
  virtual_network_name = azurerm_virtual_network.vnet-uks-compa-01.name
  resource_group_name  = azurerm_resource_group.rg-uks-compa-net-01.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "nsg-uks-compa-01-snet-01" {
  subnet_id                 = azurerm_subnet.vnet-uks-compa-01-snet-01.id
  network_security_group_id = azurerm_network_security_group.nsg-uks-compa-01.id
}

resource "azurerm_network_security_group" "nsg-uks-compa-01" {
  name                = "nsg-uks-compa-01"
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name
  location            = azurerm_resource_group.rg-uks-compa-net-01.location

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network_peering" "compa-uks-hub-uks" {
  name                      = "compa-uks-hub-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-compa-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-compa-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-hub-01.id
}

resource "azurerm_virtual_network_peering" "hub-uks-compa-uks" {
  name                      = "hub-uks-compa-uks"
  resource_group_name       = azurerm_resource_group.rg-uks-compa-net-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-hub-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-compa-01.id
}