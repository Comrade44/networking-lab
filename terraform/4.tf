resource "azurerm_subnet" "vnet-uks-hub-01-snet-azfw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg-uks-hub-01.name
  virtual_network_name = azurerm_virtual_network.vnet-uks-hub-01.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "pip-uks-hub-01" {
  name                = "pip-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  allocation_method   = "Static"
}

resource "azurerm_firewall" "azfw-uks-hub-01" {
  name                = "azfw-uks-hub-01"
  location            = azurerm_resource_group.rg-uks-hub-01.location
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration {
    name                 = "hub"
    subnet_id            = azurerm_subnet.vnet-uks-hub-01-snet-azfw.id
    public_ip_address_id = azurerm_public_ip.pip-uks-hub-01.id
  }
}

resource "azurerm_firewall_network_rule_collection" "spoke-networks" {
  name = "spoke-networks"
  azure_firewall_name = azurerm_firewall.azfw-uks-hub-01.name
  resource_group_name = azurerm_resource_group.rg-uks-hub-01.name
  priority = 100
  action = "Allow"

  rule {
    name = "allow-http-https-outbound"
    source_addresses = [ azurerm_subnet.vnet-uks-compa-01-snet-01.address_prefixes[0], azurerm_subnet.vnet-uks-compb-01-snet-01.address_prefixes[0] ]
    protocols = ["Any"]
    destination_ports = ["80", "443"]
    destination_addresses = [ "*" ]
  }
}