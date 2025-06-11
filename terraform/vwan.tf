resource "azurerm_resource_group" "rg-uks-hub-01" {
  name = "rg-uks-hub-01"
  location = "uksouth"
}
resource "azurerm_virtual_wan" "vwan-uks-hub-01" {
  name                = "vwan-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
}
