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

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  address_prefixes     = ["10.0.5.0/24"]
}

## NAT Gateway
resource "azurerm_nat_gateway" "ngw-uks-hub-01" {
  name                = "ngw-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-hub-01" {
  name                = "pip-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-hub-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-hub-01.id
}