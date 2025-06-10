resource "azurerm_resource_group" "rg-uks-mon-01" {
  name     = "rg-uks-mon-01"
  location = "uksouth"
}

resource "azurerm_log_analytics_workspace" "law-uks-mon-01" {
  name                = "law-uks-mon-01"
  location            = azurerm_resource_group.rg-uks-mon-01.location
  resource_group_name = azurerm_resource_group.rg-uks-mon-01.name
}