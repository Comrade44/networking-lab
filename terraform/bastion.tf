resource "azurerm_resource_group" "rg-uks-bas-01" {
  name     = "rg-uks-bas-01"
  location = "uksouth"
}

resource "azurerm_public_ip" "pip-uks-bas-01" {
  name                = "pip-uks-bas-01"
  location            = azurerm_resource_group.rg-uks-bas-01.location
  resource_group_name = azurerm_resource_group.rg-uks-bas-01.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bas-uks-bas-01" {
  name                = "bas-uks-bas-01"
  location            = azurerm_resource_group.rg-uks-bas-01.location
  resource_group_name = azurerm_resource_group.rg-uks-bas-01.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.pip-uks-bas-01.id
  }
}

resource "azurerm_virtual_network" "vnet-uks-bastion-01" {
  name                = "vnet-uks-bastion-01"
  location            = azurerm_resource_group.rg-uks-bas-01.location
  resource_group_name = azurerm_resource_group.rg-uks-bas-01.name
  address_space       = ["10.30.0.0/16"]
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-uks-bastion-01.name
  resource_group_name  = azurerm_resource_group.rg-uks-bas-01.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_virtual_network_peering" "bastion-spokea" {
  name                      = "bastion-spokea"
  resource_group_name       = azurerm_resource_group.rg-uks-bas-01.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks-bastion-01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spokea-bastion" {
  name                      = "spokea-bastion"
  resource_group_name       = azurerm_resource_group.rg-uks-vm.name
  virtual_network_name      = azurerm_virtual_network.vnet-uks.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-uks-bastion-01.id
}