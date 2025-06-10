resource "azurerm_nat_gateway" "ngw-uks-hub-01" {
  name                = "ngw-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-net-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-hub-03" {
  name                = "pip-uks-hub-03"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-hub-03" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-hub-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-hub-03.id
}

resource "azurerm_subnet_nat_gateway_association" "comps-ngw-subnets" {
  subnet_id      = azurerm_subnet.vnet-uks-hub-01-snet-azfw.id
  nat_gateway_id = azurerm_nat_gateway.ngw-uks-hub-01.id
}