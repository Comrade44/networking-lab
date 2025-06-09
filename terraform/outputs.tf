output "vnet" {
  value = {for x in (azurerm_virtual_network.vnet-uks-compa-01.subnet) : x.name => x}
}