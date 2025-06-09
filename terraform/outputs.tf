output "vnet" {
  value = {for x in (azurerm_virtual_network.vnet-uks-compa-01) : x.name => x}
}