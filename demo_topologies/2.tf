## NAT gateway spoke a

resource "azurerm_nat_gateway" "ngw-uks-spokea-01" {
  name                = "ngw-uks-spokea-01"
  location            = azurerm_resource_group.rg-uks-spokea-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokea-net-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-spokea-01" {
  name                = "pip-uks-spokea-01"
  location            = azurerm_resource_group.rg-uks-spokea-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokea-net-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-spokea-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-spokea-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-spokea-01.id
}

resource "azurerm_subnet_nat_gateway_association" "comps-ngw-subnets" {
  for_each = { for x in(azurerm_virtual_network.vnet-uks-spokea-01.subnet) : x.name => x }

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.ngw-uks-spokea-01.id
}

## NAT gateway spoke b

resource "azurerm_nat_gateway" "ngw-uks-spokeb-01" {
  name                = "ngw-uks-spokeb-01"
  location            = azurerm_resource_group.rg-uks-spokeb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokeb-net-01.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "pip-uks-spokeb-01" {
  name                = "pip-uks-spokeb-01"
  location            = azurerm_resource_group.rg-uks-spokeb-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokeb-net-01.name
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway_public_ip_association" "ngw-01-pip-spokeb-01" {
  nat_gateway_id       = azurerm_nat_gateway.ngw-uks-spokeb-01.id
  public_ip_address_id = azurerm_public_ip.pip-uks-spokeb-01.id
}

resource "azurerm_subnet_nat_gateway_association" "spokeb-ngw-subnets" {
  for_each = { for x in(azurerm_virtual_network.vnet-uks-spokeb-01.subnet) : x.name => x }

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.ngw-uks-spokeb-01.id
}