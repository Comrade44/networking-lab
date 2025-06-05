resource "azurerm_resource_group" "rg-uks-bas-01" {
  name = "rg-uks-bas-01"
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
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.pip-uks-bas-01.id
  }
}