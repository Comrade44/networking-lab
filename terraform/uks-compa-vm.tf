resource "azurerm_resource_group" "rg-uks-compa-vm-01" {
  name     = "rg-uks-compa-vm-01"
  location = "uksouth"
}

resource "azurerm_public_ip" "pip-uks-compa-01" {
  name                = "pip-uks-compa-01"
  location            = azurerm_resource_group.rg-uks-compa-vm-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-vm-01.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-uks-compa-01" {
  name                = "nic-uks-compa-01"
  location            = azurerm_resource_group.rg-uks-compa-vm-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-vm-01.name
  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.vnet-uks-compa-01-snet-01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-uks-compa-01.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-uks-compa-01" {
  name = "vm-uks-compa-01"
  location = azurerm_resource_group.vm-uks-compa-01.location
  resource_group_name = azurerm_resource_group.rg-uks-compa-vm-01.name
  network_interface_ids = [azurerm_network_interface.nic-uks-compa-01.id]
  size = "Standard_B1s"
  os_disk {
    storage_account_type = "Standard_LRS"
    caching = "None"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "ubuntu-24_04-lts"
    sku = "server"
    version = "latest"
  }
  admin_username = "labadmin"
  admin_ssh_key {
    username = "labadmin"
    public_key = var.ssh_public_key
  }
  
}