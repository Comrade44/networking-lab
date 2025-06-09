## NAT Gateway HUB
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

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-hub-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-hub-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-hub-01.id
}

## NAT gateway spoke a

resource "azurerm_nat_gateway" "ngw-uks-compa-01" {
  name                = "ngw-uks-compa-01"
  location            = azurerm_resource_group.rg-uks-compa-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-compa-01" {
  name                = "pip-uks-compa-01"
  location            = azurerm_resource_group.rg-uks-compa-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-net-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-compa-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-compa-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-compa-01.id
}

#resource "azurerm_subnet_nat_gateway_association" "comps-ngw-subnets" {
#  for_each = azurerm_virtual_network.vnet-uks-compa-01.subnet
#
#  subnet_id = each.value.subnet_id
#  nat_gateway_id = azurerm_nat_gateway.ngw-uks-compa-01.id
#}

## NAT gateway spoke b

resource "azurerm_nat_gateway" "ngw-uks-compb-01" {
  name                = "ngw-uks-compb-01"
  location            = azurerm_resource_group.rg-uks-compb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compb-net-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-compb-01" {
  name                = "pip-uks-compb-01"
  location            = azurerm_resource_group.rg-uks-compb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compb-net-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-compb-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-compb-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-compb-01.id
}