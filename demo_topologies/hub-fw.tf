#resource "azurerm_resource_group" "rg-uks-azfw-01" {
#  name = "rg-uks-azfw-01"
#  location = "uksouth"
#}
#
#resource "azurerm_firewall" "azfw-uks-hub-01" {
#  name = "azfw-uks-hub-01"
#  location = azurerm_resource_group.rg-uks-azfw-01.location
#  resource_group_name = azurerm_resource_group.rg-uks-azfw-01.name
#  sku_name            = "AZFW_VNet"
#  sku_tier            = "Standard"
#  firewall_vi
#}