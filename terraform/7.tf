resource "azurerm_firewall" "azfw-uks-net-01" {
  name                = "azfw-uks-net-01"
  location            = azurerm_resource_group.rg-uks-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-net-01.name
  sku_name            = "AZFW_Hub"
  sku_tier            = "Standard"
  virtual_hub {
    virtual_hub_id = azurerm_virtual_hub.vhub-uks-01.id
  }
  firewall_policy_id = azurerm_firewall_policy.firewall-policy-uks.id
}

resource "azurerm_firewall_policy" "firewall-policy-uks" {
  name = "firewall-policy-uks"
  location            = azurerm_resource_group.rg-uks-net-01.location
  resource_group_name = azurerm_resource_group.rg-uks-net-01.name
}

resource "azurerm_firewall_policy_rule_collection_group" "network-policy-uks" {
  name = "network-policy-uks"
  firewall_policy_id = azurerm_firewall_policy.firewall-policy-uks.id
  priority = 100

  network_rule_collection {
    name = "rule-collection"
    action = "Allow"
    priority = 100

    rule {
      name = "allow-http-https-outbound"
      source_addresses = [ azurerm_subnet.vnet-uks-spokea-01-snet-01.address_prefixes[0], azurerm_subnet.vnet-uks-spokeb-01-snet-01.address_prefixes[0] ]
      protocols = ["Any"]
      destination_ports = ["80", "443"]
      destination_addresses = [ "*" ]
    }
    rule {
      name = "allow-ssh-outbound"
      source_addresses = [ azurerm_subnet.vnet-uks-spokea-01-snet-01.address_prefixes[0], azurerm_subnet.vnet-uks-spokeb-01-snet-01.address_prefixes[0] ]
      protocols = ["Any"]
      destination_ports = ["22"]
      destination_addresses = [ "*" ]
    }
  }
}

#resource "azurerm_firewall_network_rule_collection" "spoke-networks" {
#  name = "spoke-networks"
#  azure_firewall_name = azurerm_firewall.azfw-uks-net-01.name
#  resource_group_name = azurerm_resource_group.rg-uks-net-01.name
#  priority = 100
#  action = "Allow"
#
#  rule {
#    name = "allow-http-https-outbound"
#    source_addresses = [ azurerm_subnet.vnet-uks-spokea-01-snet-01.address_prefixes[0], azurerm_subnet.vnet-uks-spokeb-01-snet-01.address_prefixes[0] ]
#    protocols = ["Any"]
#    destination_ports = ["80", "443"]
#    destination_addresses = [ "*" ]
#  }
#  rule {
#    name = "allow-ssh-outbound"
#    source_addresses = [ azurerm_subnet.vnet-uks-spokea-01-snet-01.address_prefixes[0], azurerm_subnet.vnet-uks-spokeb-01-snet-01.address_prefixes[0] ]
#    protocols = ["Any"]
#    destination_ports = ["22"]
#    destination_addresses = [ "*" ]
#  }
#}